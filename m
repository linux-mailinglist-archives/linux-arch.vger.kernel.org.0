Return-Path: <linux-arch+bounces-687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 540478044C1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F363E1F21317
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC94C69;
	Tue,  5 Dec 2023 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XB9ar2Xh"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DFD6D;
	Mon,  4 Dec 2023 18:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vBvpxhxAlJUtQr1e6w1WFsry5arE1IE06RFBsXpoeKs=; b=XB9ar2XhXX4BtEAi7tW7HsiwFy
	XqTD4EzZmC4q5aWyUecD8F/+olu503o9oV4DNN5kE20cJP6e2g2PfRcep0pmeVqzTM4+i0F35QmyW
	AwitCu9Q4fGDN/uZr/rW12N1Y5WfgEazSF08KNWAZF2fJR2GzJvxYXJAvxWaWQKqGX907WP0fGl7B
	89l2LwYq7GlW9ytNEM8ikxY+LaCLZsEQ/2II9mvG0wAGJaTWzLL/bL2d+/BmUtNHHUfS7COZ5RKp0
	jvS+WtpjGgRB75wM+AOtfnhMMk0vJlyuk9kX2y5A/ZilTt9ZVkXR1yaE1q/Yiz4Rl+ihFRmQ6uN0X
	wTPQdk8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6h-007928-1c;
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
Subject: [PATCH v2 3/9] udf_rename(): only access the child content on cross-directory rename
Date: Tue,  5 Dec 2023 02:23:57 +0000
Message-Id: <20231205022418.1703007-6-viro@zeniv.linux.org.uk>
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

We can't really afford locking the source on same-directory rename;
currently vfs_rename() tries to do that, but it will have to be
changed.  The logics in udf_rename() is lazy and goes looking for
".." in source even in same-directory case.  It's not hard to get
rid of that, leaving that behaviour only for cross-directory case;
that VFS can get locks safely (and will keep doing that after the
coming changes).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 3508ac484da3..fac806a7a8d4 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -766,7 +766,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct udf_fileident_iter oiter, niter, diriter;
-	bool has_diriter = false;
+	bool has_diriter = false, is_dir = false;
 	int retval;
 	struct kernel_lb_addr tloc;
 
@@ -789,6 +789,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (!empty_dir(new_inode))
 				goto out_oiter;
 		}
+		is_dir = true;
+	}
+	if (is_dir && old_dir != new_dir) {
 		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
 					       &diriter);
 		if (retval == -ENOENT) {
@@ -878,7 +881,9 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
+	}
 
+	if (is_dir) {
 		inode_dec_link_count(old_dir);
 		if (new_inode)
 			inode_dec_link_count(new_inode);
-- 
2.39.2


