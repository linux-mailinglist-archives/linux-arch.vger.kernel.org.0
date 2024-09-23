Return-Path: <linux-arch+bounces-7379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83292983A00
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2024 01:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0361F22821
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 23:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC6126BE7;
	Mon, 23 Sep 2024 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eDK4ISP1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22AB85656;
	Mon, 23 Sep 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132975; cv=none; b=LmYCgCUUnpQ1T3EfEw1OujL/1DWODhR9Lya2ZyzaUez3zrxroSQx11Qvx2YWIEnVP93GN7rNZvRsqHKgggn4quBqrlV02z5tiHmgju2rOWRjLvmfLIJnSV4GlQNb1iKHam6Z/0FmCtcdfj2uSTx3B31/fASqmL+APd6uC35xtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132975; c=relaxed/simple;
	bh=PHoVvDtoIdWZSf/ShIM2IZyXQXsUHZFPkddeumDkn9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvazXvXfjrTyXuFDfo2VlcxKYNxBF0O4PHUq1ed7A6q6gXXTiHlxundruH7zELVLVAXIj54G1AoLsIalyQMKQcmtajLDVUCqsY0TnZ/0BZssDezYxijcMA8UKBL/h28a+lc28u7rzjUOirKeKryU1o9APybqF1P37tyMM14MPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eDK4ISP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5BFC4CEC4;
	Mon, 23 Sep 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eDK4ISP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727132971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=43Vh0tWcrKvKgzDvUFrpyFzSlz2V2ztNJ6h2JpPEh18=;
	b=eDK4ISP1Sfxrg30+qTfgwlp5VetK0vNK7DrEB77tHN47PdhTljElxtvxoYM/9xjuvJu6Q5
	Oj8etovmHmqkfZARS6r7RDFrTUVZVkPSbc77ewYI4eAO6gBSqvaJ7XcybcSkgsi7x3QfRg
	+G++Rsa58mUfkX/IE/pYqKs3FVZAadM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 603268e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Sep 2024 23:09:31 +0000 (UTC)
Date: Tue, 24 Sep 2024 01:09:28 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 7/8] vdso: Introduce uapi/vdso/random.h
Message-ID: <ZvH1KKOJeq772enV@zx2c4.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-8-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923141943.133551-8-vincenzo.frascino@arm.com>

On Mon, Sep 23, 2024 at 03:19:42PM +0100, Vincenzo Frascino wrote:
> --- a/include/uapi/linux/random.h
> +++ b/include/uapi/linux/random.h
> @@ -44,30 +44,6 @@ struct rand_pool_info {
>  	__u32	buf[];
>  };
>  
> -/*
> - * Flags for getrandom(2)
> - *
> - * GRND_NONBLOCK	Don't block and return EAGAIN instead
> - * GRND_RANDOM		No effect
> - * GRND_INSECURE	Return non-cryptographic random bytes
> - */
> -#define GRND_NONBLOCK	0x0001
> -#define GRND_RANDOM	0x0002
> -#define GRND_INSECURE	0x0004
> -
> -/**
> - * struct vgetrandom_opaque_params - arguments for allocating memory for vgetrandom
> - *
> - * @size_per_opaque_state:	Size of each state that is to be passed to vgetrandom().
> - * @mmap_prot:			Value of the prot argument in mmap(2).
> - * @mmap_flags:			Value of the flags argument in mmap(2).
> - * @reserved:			Reserved for future use.
> - */
> -struct vgetrandom_opaque_params {
> -	__u32 size_of_opaque_state;
> -	__u32 mmap_prot;
> -	__u32 mmap_flags;
> -	__u32 reserved[13];
> -};
> +#include <vdso/random.h>
>  
>  #endif /* _UAPI_LINUX_RANDOM_H */
> diff --git a/include/uapi/vdso/random.h b/include/uapi/vdso/random.h
> new file mode 100644
> index 000000000000..5c80995129c2
> --- /dev/null
> +++ b/include/uapi/vdso/random.h
> @@ -0,0 +1,38 @@
> +

I really do not like this. This is UAPI, and it's linux/something.h
style of UAPI. What does moving it to vdso/ accomplish except confusion
for people looking where the code is and then polluting users'
/usr/include with extra directories that aren't meaningful?

A change like this makes me think the approach taken by this patchset
might not be the right one.

