Return-Path: <linux-arch+bounces-1842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBE84232D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 12:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE35B2CB5E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5866B4C;
	Tue, 30 Jan 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMHmAUIO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCUu1BNm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bEt7+Fb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZN+0xaMa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B1679F0;
	Tue, 30 Jan 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614422; cv=none; b=YXI9GZIlphof2CqL29p28v/rH9P83uHwu4LHRuOtTN0v5HTq+kjh7Qu2UDs6P73WqWq7bsLCor2lZ9/L9i6e8bVBr2BsOshqu5Dr5Wr/9wEtGfjjMCvJjQdihOpDycTzpOn9sQbm0Ymydq75lUx9vq5Ozh7CFhGUvfL30u2LOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614422; c=relaxed/simple;
	bh=KdleNc6ylNXLWRddKw+ypWGUY1aH6NyttfKk2hGcMgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvq4HIVg73Ibgnj5+LNpT2evIscX22xnlQOak4ZkMCENBPHoRONolTMvRHR8xRx7vUcPU4PZcZb6Vq5Q/dduM443MYiw8KDOvK6T+vgtdTocgBjjtMlcqUx52M5QanJl5OZpXhktcijIkWogx+oNgIguLo5xJn61oucxPIV4638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMHmAUIO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCUu1BNm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bEt7+Fb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZN+0xaMa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBD8D222EC;
	Tue, 30 Jan 2024 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706614419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul8XI1L/cZzOQhlwvI1+prP8LmIw3V5FpvNQXXSV384=;
	b=WMHmAUIOA7jXezAvq0ZkXKvyPhWYRVDv6j4CkOfdnTknst0pMIebKWOKs36pgauuGiThav
	4acrlDq3WeGHd+huaR6pHDvE8bPYMFc4AMbLCDaIX6NM9KxohY3i5pTv+Q3DpNJ+Vb22GV
	m/GlA8vVgU5ZyaeZQdJmXSfimOZIL/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706614419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul8XI1L/cZzOQhlwvI1+prP8LmIw3V5FpvNQXXSV384=;
	b=kCUu1BNm+2hjT4FskcjKJfLnyjAR22BERPd4NoVtsxfbAmqVrtwBy6Idg9dOpKpctlVkxW
	ioqf2Qe7qSRH/nDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706614417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul8XI1L/cZzOQhlwvI1+prP8LmIw3V5FpvNQXXSV384=;
	b=bEt7+Fb4F6iuZ2rG1MhIuzS/7eZbMXnhx+Wvwe5rxC0rdbM0s85/aC6UZufC7+BB9Tl23E
	aE9zv/1rzWgiyVfy151g+RHuv/mJ7ZPlKj+m/4P7P8DBQ/J2iift8xkLBFHsUZ+MfNLbyg
	gqm3Nwd/p27Y1Vhtqja3VmJEQdNIQHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706614417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ul8XI1L/cZzOQhlwvI1+prP8LmIw3V5FpvNQXXSV384=;
	b=ZN+0xaMaQHPUiTqxVr6sHBw3gfPjXpy8jPFBkfD9rZmxSpx+iUGYygPweVaUCf56A9k1nz
	gci3cDsnNWbLagDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D997C13462;
	Tue, 30 Jan 2024 11:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MzMrNJHeuGWXDwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 11:33:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7816AA0807; Tue, 30 Jan 2024 12:33:37 +0100 (CET)
Date: Tue, 30 Jan 2024 12:33:37 +0100
From: Jan Kara <jack@suse.cz>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] ext2: Use dax_is_supported()
Message-ID: <20240130113337.frem6a3y5n2iibnh@quack3>
References: <20240129210631.193493-1-mathieu.desnoyers@efficios.com>
 <20240129210631.193493-5-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129210631.193493-5-mathieu.desnoyers@efficios.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[kvack.org:email,intel.com:email,suse.cz:email,suse.com:email,linux-foundation.org:email,linux.dev:email,infradead.org:email,efficios.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 29-01-24 16:06:28, Mathieu Desnoyers wrote:
> Use dax_is_supported() to validate whether the architecture has
> virtually aliased caches at mount time.
> 
> This is relevant for architectures which require a dynamic check
> to validate whether they have virtually aliased data caches
> (ARCH_HAS_CACHE_ALIASING_DYNAMIC=y).
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org

Looks good to me (although I share Dave's opinion it would be nice to CC
the whole series to fsdevel - luckily we have lore these days so it is not
that tedious to find the whole series :)). Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/super.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 01f9addc8b1f..0398e7a90eb6 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -585,13 +585,13 @@ static int parse_options(char *options, struct super_block *sb,
>  			set_opt(opts->s_mount_opt, XIP);
>  			fallthrough;
>  		case Opt_dax:
> -#ifdef CONFIG_FS_DAX
> -			ext2_msg(sb, KERN_WARNING,
> -		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> -			set_opt(opts->s_mount_opt, DAX);
> -#else
> -			ext2_msg(sb, KERN_INFO, "dax option not supported");
> -#endif
> +			if (dax_is_supported()) {
> +				ext2_msg(sb, KERN_WARNING,
> +					 "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> +				set_opt(opts->s_mount_opt, DAX);
> +			} else {
> +				ext2_msg(sb, KERN_INFO, "dax option not supported");
> +			}
>  			break;
>  
>  #if defined(CONFIG_QUOTA)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

