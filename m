Return-Path: <linux-arch+bounces-12069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18FAC0B66
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 14:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D047B3668
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25125289E35;
	Thu, 22 May 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ebuxk8DE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817423771C;
	Thu, 22 May 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915934; cv=none; b=UW0vUcw61nO4jAiIGia48/S2XsZNOY5QTwMqdP89z7cox3OIkJ6F6/SsYMW09ljdq2XmIgFoegSOvveq6hbgVfjjvYwi5NIWbGWrEDeYvTXxrpbxur/VanwH6ilanLtDFV5v3s8NlIdRAU+pobrmohjQS1/e/d9HFbc0Y0yInvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915934; c=relaxed/simple;
	bh=StgdFeaMD6HJ9Me6GTfwzhiv4ow8/NpvUc+y4NUni2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfmFtGhT908SmHbjXIjk2kwhobkSmEm+UsPSijFEIV+cxLH/GtftxvuPy1tJxwjfjwB19AaCTOZUNjDfoPok5K1zOb/GnGPrOgeQYqJiuCcAriDZkOzlLe9kwoNH5z1HyrOdkzh6tUS/P5tDOUhYlw7uRoeZcxEynpJn8JFCGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ebuxk8DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20577C4CEE4;
	Thu, 22 May 2025 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747915933;
	bh=StgdFeaMD6HJ9Me6GTfwzhiv4ow8/NpvUc+y4NUni2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ebuxk8DElK2tjp5ZvQk37kLGix2yfChyW3I8J7FaPYbTLnjfLorYdKkX+7JjgSqgl
	 LY5N5YuC/VI1iHjtA8x39j2I5hf52LIGXT+m6csvpWdIx/AuCTHq5Md2yu1gfQcfoH
	 YQnRPECrpFToWi9CiW2CUoy1kaCr5lcz9r0UNC+ql9WEcasfbFweM5E/h5jhl1C23y
	 zUYk/oiHGTD2iNYap4ZuSBn7FBR7jllob9uHds31/Q4MKcCGD5K2SHdX8Vt5oShScH
	 61P8SWTu0oAQ3/REBM85O1ghJY686cDchWGnVILgvEbFYcTF6BiEDn7lOAe3Q2h4qr
	 mnnenoduIsqMA==
Date: Thu, 22 May 2025 15:12:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
	linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <aC8UlSupN7_YXfma@kernel.org>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>

(cc'ing linux-api)

On Mon, May 19, 2025 at 09:52:37PM +0100, Lorenzo Stoakes wrote:
> REVIEWERS NOTES:
> ================
> 
> This is a VERY EARLY version of the idea, it's relatively untested, and I'm
> 'putting it out there' for feedback. Any serious version of this will add a
> bunch of self-tests to assert correct behaviour and I will more carefully
> confirm everything's working.
> 
> This is based on discussion arising from Usama's series [0], SJ's input on
> the thread around process_madvise() behaviour [1] (and a subsequent
> response by me [2]) and prior discussion about a new madvise() interface
> [3].
> 
> [0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
> [1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
> [2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
> [3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/
> 
> ================
> 
> Currently, we are rather restricted in how madvise() operations
> proceed. While effort has been put in to expanding what process_madvise()
> can do (that is - unrestricted application of advice to the local process
> alongside recent improvements on the efficiency of TLB operations over
> these batvches), we are still constrained by existing madvise() limitations
> and default behaviours.
> 
> This series makes use of the currently unused flags field in
> process_madvise() to provide more flexiblity.
> 
> It introduces four flags:
> 
> 1. PMADV_SKIP_ERRORS
> 
> Currently, when an error arises applying advice in any individual VMA
> (keeping in mind that a range specified to madvise() or as part of the
> iovec passed to process_madvise()), the operation stops where it is and
> returns an error.
> 
> This might not be the desired behaviour of the user, who may wish instead
> for the operation to be 'best effort'. By setting this flag, that behaviour
> is obtained.
> 
> Since process_madvise() would trivially, if skipping errors, simply return
> the input vector size, we instead return the number of entries in the
> vector which completed successfully without error.
> 
> The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.
> 
> 2. PMADV_NO_ERROR_ON_UNMAPPED
> 
> Currently madvise() has the peculiar behaviour of, if the range specified
> to it contains unmapped range(s), completing the full operation, but
> ultimately returning -ENOMEM.
> 
> In the case of process_madvise(), this is fatal, as the operation will stop
> immediately upon this occurring.
> 
> By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
> unmapped areas to simply be entirely ignored.
> 
> 3. PMADV_SET_FORK_EXEC_DEFAULT
> 
> It may be desirable for a user to specify that all VMAs mapped in a process
> address space default to having an madvise() behaviour established by
> default, in such a fashion as that this persists across fork/exec.
> 
> Since this is a very powerful option that would make no sense for many
> advice modes, we explicitly only permit known-safe flags here (currently
> MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
> 
> 4. PMADV_ENTIRE_ADDRESS_SPACE
> 
> It can be annoying, should a user wish to apply madvise() to all VMAs in an
> address space, to have to add a singular large entry to the input iovec.
> 
> So provide sugar to permit this - PMADV_ENTIRE_ADDRESS_SPACE. If specified,
> we expect the user to pass NULL and -1 to the vec and vlen parameters
> respectively so they explicitly acknowledge that these will be ignored,
> e.g.:
> 
> 	process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
> 			PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS);
> 
> Usually a user ought to prefer setting PMADV_SKIP_ERRORS here as it may
> well be the case that incompatible VMAs will be encountered that ought to
> be skipped.
> 
> If this is not set, the PMADV_NO_ERROR_ON_UNMAPPED (which was otherwise
> implicitly implied by PMADV_SKIP_ERRORS) ought to be set as of course, the
> entire address space spans at least some gaps.
> 
> Lorenzo Stoakes (5):
>   mm: madvise: refactor madvise_populate()
>   mm/madvise: add PMADV_SKIP_ERRORS process_madvise() flag
>   mm/madvise: add PMADV_NO_ERROR_ON_UNMAPPED process_madvise() flag
>   mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT process_madvise() flag
>   mm/madvise: add PMADV_ENTIRE_ADDRESS_SPACE process_madvise() flag
> 
>  include/uapi/asm-generic/mman-common.h |   6 +
>  mm/madvise.c                           | 206 +++++++++++++++++++------
>  2 files changed, 168 insertions(+), 44 deletions(-)
> 
> --
> 2.49.0
> 

-- 
Sincerely yours,
Mike.

