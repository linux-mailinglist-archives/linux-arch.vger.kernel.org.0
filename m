Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7154EF7BD
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 10:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfKEJFi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 04:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:57408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727095AbfKEJFi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 04:05:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B056DAC71;
        Tue,  5 Nov 2019 09:05:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 220971E4407; Tue,  5 Nov 2019 10:05:35 +0100 (CET)
Date:   Tue, 5 Nov 2019 10:05:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Message-ID: <20191105090535.GI22379@quack2.suse.cz>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon 04-11-19 21:46:14, Valdis Kletnieks wrote:
> Four filesystems have their own defines for this. Move it
> into errno.h so it's defined in just one place.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Thanks for the patch! It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h                   | 2 --
>  fs/f2fs/f2fs.h                   | 2 --
>  fs/xfs/xfs_linux.h               | 1 -
>  include/linux/jbd2.h             | 2 --
>  include/uapi/asm-generic/errno.h | 1 +
>  5 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index a86c2585457d..79b3fd8291ab 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3395,6 +3395,4 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  
>  #endif	/* __KERNEL__ */
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -
>  #endif	/* _EXT4_H */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 04ebe77569a3..ba23fd18d44a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3751,6 +3751,4 @@ static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
>  	return false;
>  }
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -
>  #endif /* _LINUX_F2FS_H */
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index 3409d02a7d21..abdfc506618d 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -123,7 +123,6 @@ typedef __u32			xfs_nlink_t;
>  
>  #define ENOATTR		ENODATA		/* Attribute not found */
>  #define EWRONGFS	EINVAL		/* Mount with wrong filesystem type */
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>  
>  #define SYNCHRONIZE()	barrier()
>  #define __return_address __builtin_return_address(0)
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 69411d7e0431..e07692fe6f20 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1656,6 +1656,4 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
>  
>  #endif	/* __KERNEL__ */
>  
> -#define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> -
>  #endif	/* _LINUX_JBD2_H */
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index 1d5ffdf54cb0..e4cae9a9ae79 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -55,6 +55,7 @@
>  #define	EMULTIHOP	72	/* Multihop attempted */
>  #define	EDOTDOT		73	/* RFS specific error */
>  #define	EBADMSG		74	/* Not a data message */
> +#define EFSBADCRC	EBADMSG	/* Bad CRC detected */
>  #define	EOVERFLOW	75	/* Value too large for defined data type */
>  #define	ENOTUNIQ	76	/* Name not unique on network */
>  #define	EBADFD		77	/* File descriptor in bad state */
> -- 
> 2.24.0.rc1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
