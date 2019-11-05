Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F32F010A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbfKEPSJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 10:18:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389339AbfKEPSJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 10:18:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5FBEnb003374;
        Tue, 5 Nov 2019 15:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=osE8j9hQwuSePK7ZTlyMlstj+2/UeTh7rzDs6aVJ5Rs=;
 b=Vxe9Jb+yTzWtouNkh26DXmbK2Y72PPwXLMqnj30vt2sFem5vHfSIowSkEVOvyk9xaN7n
 pHDYkHoCGvMdO0POWi1TB5XwsDLdXuyKzYR6j1gIFpqgYdqzvMMtHY5CtPwyKBob1ltn
 Ff7RJ6digC/RRqJ3PwTVQv3wqYIJ7LLxI2RgzdsO/pHo2CBW/nwfRazbzyz6Jp/vlR37
 j3+XluxM8vfzoHwDwoU7HoAVK0nqJPqI1fsYWrGnElRUlvU2wfNhaYbAZW6O5YsiKsav
 JnBJuVkoLV7nL61BPOyzAVrSUtxMgpPwqb3SSoHVMbnXSWp05veV4HNIKvslrh7eHkuW Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12er71ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:17:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA5FBeHf064216;
        Tue, 5 Nov 2019 15:17:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w333vcjme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Nov 2019 15:17:46 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA5FHdUJ011774;
        Tue, 5 Nov 2019 15:17:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 07:17:38 -0800
Date:   Tue, 5 Nov 2019 07:17:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Message-ID: <20191105151736.GB4153244@magnolia>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911050126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911050126
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 04, 2019 at 09:46:14PM -0500, Valdis Kletnieks wrote:
> Four filesystems have their own defines for this. Move it
> into errno.h so it's defined in just one place.
> 
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Acked-by: Darrick J. Wong <darrick.wong@oracle.com>

You can build all six filesystems with both this and the EFSCORRUPTED
patch applied, correct?

--D

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
