Return-Path: <linux-arch+bounces-664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E48044A8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B26B20B05
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46114A34;
	Tue,  5 Dec 2023 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TIN2rLHw"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C98610F;
	Mon,  4 Dec 2023 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1kXdQTzP9QbMwip9HhQkODeDCTy6uPz4pJDbGLrfwH4=; b=TIN2rLHwJM9EnMlKGMZ3+UixZd
	6ZAAU6BcSIeX1Tdupwr4sOYumjzoDu9npdMdeoScH5yBlbbhfLEYT1n1InaswtEJ3zlArIiMMzUBy
	S4H/KsWiEpKhcmSM5iL3HhGeGaiCqcAAR/Mf8Jo+0FsDuKi6xVfRhhJTi3BvqCLVfAtgeoVa/x6Lc
	dVIAByfTXF/n5im83qZjIenUOEhtJTpCj9Gmy8SO9v5sf/xlFVVkh+pTxztsYSptdaPYgcge97e72
	bgPohg0HxHRGSknDY9P1ZiNLzishSSL0mQfQnbXILTVcbJkzHLezJvE+BftSVgQ2K5YrEpdZrF5Em
	Yxnre5sw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6i-00792e-2T;
	Tue, 05 Dec 2023 02:24:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 6/9] f2fs: Avoid reading renamed directory if parent does not change
Date: Tue,  5 Dec 2023 02:24:03 +0000
Message-Id: <20231205022418.1703007-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Jan Kara <jack@suse.cz>

The VFS will not be locking moved directory if its parent does not
change.  Change f2fs rename code to avoid reading renamed directory if
its parent does not change.  Having it uninlined while we are reading
it would cause trouble and we won't be able to rely upon ->i_rwsem
on the directory being renamed in cases that do not alter its parent.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/f2fs/namei.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..fdc97df6bb85 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -963,6 +963,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -1017,7 +1018,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		goto out;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
 		if (!old_dir_entry) {
 			if (IS_ERR(old_dir_page))
@@ -1029,7 +1030,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (new_inode) {
 
 		err = -ENOTEMPTY;
-		if (old_dir_entry && !f2fs_empty_dir(new_inode))
+		if (old_is_dir && !f2fs_empty_dir(new_inode))
 			goto out_dir;
 
 		err = -ENOENT;
@@ -1054,7 +1055,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_inode, false);
 		f2fs_i_links_write(new_inode, false);
 		f2fs_up_write(&F2FS_I(new_inode)->i_sem);
@@ -1074,12 +1075,12 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			goto out_dir;
 		}
 
-		if (old_dir_entry)
+		if (old_is_dir)
 			f2fs_i_links_write(new_dir, true);
 	}
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
-	if (!old_dir_entry || whiteout)
+	if (!old_is_dir || whiteout)
 		file_lost_pino(old_inode);
 	else
 		/* adjust dir's i_pino to pass fsck check */
@@ -1105,8 +1106,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		iput(whiteout);
 	}
 
-	if (old_dir_entry) {
-		if (old_dir != new_dir && !whiteout)
+	if (old_is_dir) {
+		if (old_dir_entry && !whiteout)
 			f2fs_set_link(old_inode, old_dir_entry,
 						old_dir_page, new_dir);
 		else
-- 
2.39.2


