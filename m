Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAAEA885
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 02:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfJaBID (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 21:08:03 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43238 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbfJaBID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 21:08:03 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9V181re019583
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 21:08:01 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9V17u0h030057
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 21:08:01 -0400
Received: by mail-qt1-f198.google.com with SMTP id i1so3686956qtj.19
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 18:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=A6x5zvKJWNelVsaR2qz0QPsCww3yKpvWiohVOKat7vg=;
        b=kxvUrFG4dNISlLpUJO5NdNZ1ckl2uW6GRalT08F87iQ/srMhCsS667th9qgAfNV5cs
         jHeUJ0lMYvW44Y8Utmd+eZS5XzJt8gmRxEQS6C8CKYqdzJoUqnMKYxYr4Y57hRubsEeh
         dnwXj7+qqjKjBQ97vGoB8MIRJVFczvAXpkYKYX7R7KnTKOzH+fHSK3bz2LPQJvKCVovl
         EFZncx9GKwKObe6CCkOehH3Q7IOtZlWXtJ+ZJkGo80tAkhpi1U7Q7997t50GdeX/qAwj
         DS1WV1eHTQi7vsvgDmmkxHthgxquVYR7toAfo99OXnHzL/nl/ReMEFiW64t9pMZy2nxv
         VPUQ==
X-Gm-Message-State: APjAAAXLGr2jcKJrawx/H7fKKGCrEeqUB491CeJWEgtFYByq4DIHFD+u
        aWqacmA2hcPVbgslxo4XKrelQFsg343hftYfsBTy9jRC7swgQOPJm8SfP6halS8+2v8JQfldjs3
        BYrx7aVW/fZfYHzInx5eYFOLZOYrDeoRB
X-Received: by 2002:a05:620a:12c2:: with SMTP id e2mr2944283qkl.162.1572484075633;
        Wed, 30 Oct 2019 18:07:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlE8kPCGfGf/g8Sz78JkaUwhSUp0GYw6gPnzEQRzaLcuBtPOcj575mA0HsP7G//KxKX1X8dA==
X-Received: by 2002:a05:620a:12c2:: with SMTP id e2mr2944240qkl.162.1572484075278;
        Wed, 30 Oct 2019 18:07:55 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id u9sm1042529qke.50.2019.10.30.18.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 18:07:53 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Date:   Wed, 30 Oct 2019 21:07:33 -0400
Message-Id: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
(c) if one patch, who gets to shepherd it through?


There's currently 6 filesystems that have the same #define. Move it
into errno.h so it's defined in just one place.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h    | 2 --
 fs/erofs/internal.h              | 2 --
 fs/ext4/ext4.h                   | 1 -
 fs/f2fs/f2fs.h                   | 1 -
 fs/xfs/xfs_linux.h               | 1 -
 include/linux/jbd2.h             | 1 -
 include/uapi/asm-generic/errno.h | 1 +
 7 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 84de1123e178..3cf7e54af0b7 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -30,8 +30,6 @@
 #undef DEBUG
 #endif
 
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
-
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 544a453f3076..3980026a8882 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -425,7 +425,5 @@ static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
-#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
-
 #endif	/* __EROFS_INTERNAL_H */
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 03db3e71676c..a86c2585457d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3396,6 +3396,5 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _EXT4_H */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4024790028aa..04ebe77569a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3752,6 +3752,5 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
 }
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif /* _LINUX_F2FS_H */
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index ca15105681ca..3409d02a7d21 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
 
 #define ENOATTR		ENODATA		/* Attribute not found */
 #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 
 #define SYNCHRONIZE()	barrier()
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 564793c24d12..1ecd3859d040 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1657,6 +1657,5 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
 #endif	/* __KERNEL__ */
 
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
-#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
 #endif	/* _LINUX_JBD2_H */
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index cf9c51ac49f9..1d5ffdf54cb0 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -98,6 +98,7 @@
 #define	EINPROGRESS	115	/* Operation now in progress */
 #define	ESTALE		116	/* Stale file handle */
 #define	EUCLEAN		117	/* Structure needs cleaning */
+#define	EFSCORRUPTED	EUCLEAN
 #define	ENOTNAM		118	/* Not a XENIX named type file */
 #define	ENAVAIL		119	/* No XENIX semaphores available */
 #define	EISNAM		120	/* Is a named type file */
-- 
2.24.0.rc1

