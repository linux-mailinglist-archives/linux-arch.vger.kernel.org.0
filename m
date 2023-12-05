Return-Path: <linux-arch+bounces-682-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDD8044B9
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55ED1C20B87
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAA5381;
	Tue,  5 Dec 2023 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sG2R03ek"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B319B;
	Mon,  4 Dec 2023 18:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T08sUyzdKaybfEkZCNae4ocOGsjYgJj1qnspFJtuRWw=; b=sG2R03ekVwwAxoq11TFm7JYoNF
	LBzgdyhR0BPn4bSp+rm5Q/rwH6wBDh9Zb7Wp/GjnViZelURXwrV68kMLIGNyVSns+QMr5M4qRfqH+
	cc/j/YX5S0Ps/6k/c7cUuaFYkv647kmCb3Al9Zn+2BcQzeSP0Vo9Q0VQ8q7UBdlMn5UdNVZudqKT5
	JnTEmRlOVHn412hWtQWUkWCPPtTHUbDZHo31J8muxpz1ttkwaBZHvgUIx12SuvabvGWGyqocb1AvN
	skzKt4RgIbOTs6oKoMD2oAAYwFC98RfyhHXYvH6If2i3IKTXulQkYt+U682n5Y1tBFhb12eXQIKm2
	RHf3LYMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6h-00792A-2A;
	Tue, 05 Dec 2023 02:24:19 +0000
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
Subject: [PATCH v2 4/9] ext2: Avoid reading renamed directory if parent does not change
Date: Tue,  5 Dec 2023 02:23:58 +0000
Message-Id: <20231205022418.1703007-7-viro@zeniv.linux.org.uk>
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
change. Change ext2 rename code to avoid reading renamed directory if
its parent does not change. Although it is currently harmless it is a
bad practice to read directory contents without inode->i_rwsem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ext2/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 65f702b1da5b..8346ab9534c1 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -325,6 +325,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	struct ext2_dir_entry_2 * dir_de = NULL;
 	struct folio * old_folio;
 	struct ext2_dir_entry_2 * old_de;
+	bool old_is_dir = S_ISDIR(old_inode->i_mode);
 	int err;
 
 	if (flags & ~RENAME_NOREPLACE)
@@ -342,7 +343,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	if (IS_ERR(old_de))
 		return PTR_ERR(old_de);
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (old_is_dir && old_dir != new_dir) {
 		err = -EIO;
 		dir_de = ext2_dotdot(old_inode, &dir_folio);
 		if (!dir_de)
@@ -354,7 +355,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		struct ext2_dir_entry_2 *new_de;
 
 		err = -ENOTEMPTY;
-		if (dir_de && !ext2_empty_dir (new_inode))
+		if (old_is_dir && !ext2_empty_dir(new_inode))
 			goto out_dir;
 
 		new_de = ext2_find_entry(new_dir, &new_dentry->d_name,
@@ -368,14 +369,14 @@ static int ext2_rename (struct mnt_idmap * idmap,
 		if (err)
 			goto out_dir;
 		inode_set_ctime_current(new_inode);
-		if (dir_de)
+		if (old_is_dir)
 			drop_nlink(new_inode);
 		inode_dec_link_count(new_inode);
 	} else {
 		err = ext2_add_link(new_dentry, old_inode);
 		if (err)
 			goto out_dir;
-		if (dir_de)
+		if (old_is_dir)
 			inode_inc_link_count(new_dir);
 	}
 
@@ -387,7 +388,7 @@ static int ext2_rename (struct mnt_idmap * idmap,
 	mark_inode_dirty(old_inode);
 
 	err = ext2_delete_entry(old_de, old_folio);
-	if (!err && dir_de) {
+	if (!err && old_is_dir) {
 		if (old_dir != new_dir)
 			err = ext2_set_link(old_inode, dir_de, dir_folio,
 					    new_dir, false);
-- 
2.39.2


