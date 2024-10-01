Return-Path: <linux-arch+bounces-7508-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A04598B549
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B45F1C2290F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 07:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11581BC9E5;
	Tue,  1 Oct 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6hjsjhG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8283307B;
	Tue,  1 Oct 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767125; cv=none; b=Lo2W+3u7En5m/sn4chyYMfFY2HghHmKDNfnjYanPAACJoycQgIE9EnubOe+UPJZduk8co5LaS8BDEybbrXLjn4qqBDGAzzjaBdv450pP6XzibSHxFldjFPGVLipAfwk7eQpO6YO1POsc7Slf1c6YORPk69vtEYgXidYLP3AMyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767125; c=relaxed/simple;
	bh=THnBpzHxCYIjdDtD+X6PsiIrzTiH+/AUT0R8bh8DnZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZMlH4fznJZ1biBvFqxiNtk18Gsr1J5RV9do/wcFKfpgzUs5SFcMtcoddkse2Pmtw1w9BFb7ec4msaG2nHaKAfRU1ufz/J4mBbCrER4W8UkGS84jXYPxuUPlVv3GfyqmBbjWJXxR60PJNbSFXtfpfOKq0MJupjHql2hNbjE8VoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6hjsjhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A764C4CEC6;
	Tue,  1 Oct 2024 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727767124;
	bh=THnBpzHxCYIjdDtD+X6PsiIrzTiH+/AUT0R8bh8DnZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6hjsjhGiADhlEEyGcXO6Vn/U+HfO58lVjBiMdO8Rh1hG0Kwr+B3a+z+ZWeM46Nd2
	 cItPv6ENWSWMQ0EAZ+mfPykG1Z/dv4OqNqcdt+yMlbCd69OnjWC/b5VcZrbXCaSBxH
	 guR9eCirZTNct+9JbfDvcpeauWqAWJTLcWWKP93JPyHhe3mPaNzJCsmRSftnLrhzXA
	 NHzqwCqh/jeM5MxuBxi9N0MWlSF0ed2poDEBcOWpsi8qnrt1reKFuPIVx0Ck0B2F2W
	 JKPrHaJBDmNfjgf6moEX5kDawn6X99emoE1WKhyjmo6Jyj+hnfFNqmQLJMNScwlgJ+
	 v0Sdps/sNMDIA==
Date: Tue, 1 Oct 2024 00:18:41 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Keith Packard <keithp@keithp.com>,
	Justin Stitt <justinstitt@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-efi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-sparse@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-perf-users@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 24/28] tools/objtool: Treat indirect ftrace calls as
 direct calls
Message-ID: <20241001071841.yrc7cxdp2unnzju7@treble>
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-54-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925150059.3955569-54-ardb+git@google.com>

On Wed, Sep 25, 2024 at 05:01:24PM +0200, Ard Biesheuvel wrote:
> +		if (insn->type == INSN_CALL_DYNAMIC) {
> +			if (!reloc)
> +				continue;
> +
> +			/*
> +			 * GCC 13 and older on x86 will always emit the call to
> +			 * __fentry__ using a relaxable GOT-based symbol
> +			 * reference when operating in PIC mode, i.e.,
> +			 *
> +			 *   call   *0x0(%rip)
> +			 *             R_X86_64_GOTPCRELX  __fentry__-0x4
> +			 *
> +			 * where it is left up to the linker to relax this into
> +			 *
> +			 *   call   __fentry__
> +			 *   nop
> +			 *
> +			 * if __fentry__ turns out to be DSO local, which is
> +			 * always the case for vmlinux. Given that this
> +			 * relaxation is mandatory per the x86_64 psABI, these
> +			 * calls can simply be treated as direct calls.
> +			 */
> +			if (arch_ftrace_match(reloc->sym->name)) {
> +				insn->type = INSN_CALL;
> +				add_call_dest(file, insn, reloc->sym, false);
> +			}

Can the compiler also do this for non-fentry direct calls?  If so would
it make sense to generalize this by converting all
INSN_CALL_DYNAMIC+reloc to INSN_CALL?

And maybe something similar for add_jump_destinations().

-- 
Josh

