Return-Path: <linux-arch+bounces-8836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5879BB9A1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 16:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE6282B34
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641731C07E2;
	Mon,  4 Nov 2024 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+r634Er"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE670816;
	Mon,  4 Nov 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735942; cv=none; b=YUSkITEI5yVp0C3vD9K3CaZ6Wc42jhaWi1MSpnuxLux2D5BVC9e4Cb+Z4T7NTmkjgclxeIHZ2bK8v7gPWIS/ZmtGz4FzctB2PfuPZLApPQjVsj0Eps7BBEZLU6Fhp65bq65DkyRcu+GXqNdYRcuquZCgBmoNyIQgo2oHi1d6bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735942; c=relaxed/simple;
	bh=nfbYyjxKn/6I7KeeEZRpVU1jWeaAip9FWL9OkYwgvck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYa8muGXkI7K/f8Nx2E+bFKIWkUPPfpKxnp3q99I91dzvcm/tJjqrXHjWrI6t5Zd3t5/22hdolyul8EZHw6xYbYT9fhmHX1rQXr2HpujF6VrkuAngUmokXCfv3EEyC06KVwdcD4F6bsJUDGEzlemv3s41zD168ezRWmT7Lrcin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+r634Er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93956C4CECE;
	Mon,  4 Nov 2024 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730735941;
	bh=nfbYyjxKn/6I7KeeEZRpVU1jWeaAip9FWL9OkYwgvck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+r634Erl+WncXlEz4rsmMXCY8pHbVcHBzX48fyrMeKPL0TKRWGO+wiqFNNk2+bG3
	 +EpXJQRdYvygLy9/3ELIAb/8ofnXplEM6wi31doRQhPpma9mFRpzKmtc8jteqnIuuQ
	 y2hUCBnfM2JitLA7URtD/EpPbu2C3HrK6XK+ZsPGzQczgr5Ywo4JZ4LkH1xj3Rlsvd
	 cnObx/9CHx2OljMMP4/ygK8PuiYs7OjnWWXkoHfXClw6C6fM35CEVlbxx3SdrDa+kG
	 mKkn8iOJFfd3EOnWuF6R5QB2V6M0bDB2CQXbwqP5lD5+gYZVgejmFCy0JGPvPxHlu1
	 YJOPQwrbsGUyg==
Date: Mon, 4 Nov 2024 07:59:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 15/18] ext4: switch to using the crc32c library
Message-ID: <20241104155900.GH21832@frogsfrogsfrogs>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-16-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103223154.136127-16-ebiggers@kernel.org>

On Sun, Nov 03, 2024 at 02:31:51PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/Kconfig |  3 +--
>  fs/ext4/ext4.h  | 25 +++----------------------
>  fs/ext4/super.c | 15 ---------------
>  3 files changed, 4 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index e20d59221fc0..c9ca41d91a6c 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -29,12 +29,11 @@ config EXT3_FS_SECURITY
>  config EXT4_FS
>  	tristate "The Extended 4 (ext4) filesystem"
>  	select BUFFER_HEAD
>  	select JBD2
>  	select CRC16
> -	select CRYPTO
> -	select CRYPTO_CRC32C
> +	select CRC32

Hmm.  Looking at your git branch (which was quite helpful to link to!) I
think for XFS we don't need to change the crc32c() calls, and the only
porting work that needs to be done is mirroring this Kconfig change?
And that doesn't even need to be done until someone wants to get rid of
CONFIG_LIBCRC32C, right?

>  	select FS_IOMAP
>  	select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>  	help
>  	  This is the next generation of the ext3 filesystem.
>  
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..99aa512a7de1 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -31,11 +31,11 @@
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
>  #include <linux/blockgroup_lock.h>
>  #include <linux/percpu_counter.h>
>  #include <linux/ratelimit.h>
> -#include <crypto/hash.h>
> +#include <linux/crc32c.h>
>  #include <linux/falloc.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/fiemap.h>
>  #ifdef __KERNEL__
>  #include <linux/compat.h>
> @@ -1660,13 +1660,10 @@ struct ext4_sb_info {
>  	struct task_struct *s_mmp_tsk;
>  
>  	/* record the last minlen when FITRIM is called. */
>  	unsigned long s_last_trim_minblks;
>  
> -	/* Reference to checksum algorithm driver via cryptoapi */
> -	struct crypto_shash *s_chksum_driver;
> -
>  	/* Precomputed FS UUID checksum for seeding other checksums */
>  	__u32 s_csum_seed;
>  
>  	/* Reclaim extents from extent status tree */
>  	struct shrinker *s_es_shrinker;
> @@ -2465,23 +2462,11 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
>  #define DX_HASH_LAST 			DX_HASH_SIPHASH
>  
>  static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
>  			      const void *address, unsigned int length)
>  {
> -	struct {
> -		struct shash_desc shash;
> -		char ctx[4];
> -	} desc;
> -
> -	BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));
> -
> -	desc.shash.tfm = sbi->s_chksum_driver;
> -	*(u32 *)desc.ctx = crc;
> -
> -	BUG_ON(crypto_shash_update(&desc.shash, address, length));
> -
> -	return *(u32 *)desc.ctx;
> +	return crc32c(crc, address, length);
>  }
>  
>  #ifdef __KERNEL__
>  
>  /* hash info structure used by the directory hash */
> @@ -3278,15 +3263,11 @@ extern void ext4_group_desc_csum_set(struct super_block *sb, __u32 group,
>  extern int ext4_register_li_request(struct super_block *sb,
>  				    ext4_group_t first_not_zeroed);
>  
>  static inline int ext4_has_metadata_csum(struct super_block *sb)
>  {
> -	WARN_ON_ONCE(ext4_has_feature_metadata_csum(sb) &&
> -		     !EXT4_SB(sb)->s_chksum_driver);
> -
> -	return ext4_has_feature_metadata_csum(sb) &&
> -	       (EXT4_SB(sb)->s_chksum_driver != NULL);
> +	return ext4_has_feature_metadata_csum(sb);
>  }

Nit: Someone might want to
s/ext4_has_metadata_csum/ext4_has_feature_metadata_csum/ here to get rid
of the confusingly named trivial helper.

Otherwise this logic looks ok to me, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


>  
>  static inline int ext4_has_group_desc_csum(struct super_block *sb)
>  {
>  	return ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..1a821093cc0d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1371,12 +1371,10 @@ static void ext4_put_super(struct super_block *sb)
>  	 * Now that we are completely done shutting down the
>  	 * superblock, we need to actually destroy the kobject.
>  	 */
>  	kobject_put(&sbi->s_kobj);
>  	wait_for_completion(&sbi->s_kobj_unregister);
> -	if (sbi->s_chksum_driver)
> -		crypto_free_shash(sbi->s_chksum_driver);
>  	kfree(sbi->s_blockgroup_lock);
>  	fs_put_dax(sbi->s_daxdev, NULL);
>  	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	utf8_unload(sb->s_encoding);
> @@ -4586,19 +4584,10 @@ static int ext4_init_metadata_csum(struct super_block *sb, struct ext4_super_blo
>  		return -EINVAL;
>  	}
>  	ext4_setup_csum_trigger(sb, EXT4_JTR_ORPHAN_FILE,
>  				ext4_orphan_file_block_trigger);
>  
> -	/* Load the checksum driver */
> -	sbi->s_chksum_driver = crypto_alloc_shash("crc32c", 0, 0);
> -	if (IS_ERR(sbi->s_chksum_driver)) {
> -		int ret = PTR_ERR(sbi->s_chksum_driver);
> -		ext4_msg(sb, KERN_ERR, "Cannot load crc32c driver.");
> -		sbi->s_chksum_driver = NULL;
> -		return ret;
> -	}
> -
>  	/* Check superblock checksum */
>  	if (!ext4_superblock_csum_verify(sb, es)) {
>  		ext4_msg(sb, KERN_ERR, "VFS: Found ext4 filesystem with "
>  			 "invalid superblock checksum.  Run e2fsck?");
>  		return -EFSBADCRC;
> @@ -5638,13 +5627,10 @@ failed_mount8: __maybe_unused
>  	flush_work(&sbi->s_sb_upd_work);
>  	ext4_stop_mmpd(sbi);
>  	del_timer_sync(&sbi->s_err_report);
>  	ext4_group_desc_free(sbi);
>  failed_mount:
> -	if (sbi->s_chksum_driver)
> -		crypto_free_shash(sbi->s_chksum_driver);
> -
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	utf8_unload(sb->s_encoding);
>  #endif
>  
>  #ifdef CONFIG_QUOTA
> @@ -7433,8 +7419,7 @@ static void __exit ext4_exit_fs(void)
>  }
>  
>  MODULE_AUTHOR("Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others");
>  MODULE_DESCRIPTION("Fourth Extended Filesystem");
>  MODULE_LICENSE("GPL");
> -MODULE_SOFTDEP("pre: crc32c");
>  module_init(ext4_init_fs)
>  module_exit(ext4_exit_fs)
> -- 
> 2.47.0
> 
> 

