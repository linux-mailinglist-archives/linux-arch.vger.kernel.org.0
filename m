Return-Path: <linux-arch+bounces-10132-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC81A32D6A
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5079E1884804
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0625B69F;
	Wed, 12 Feb 2025 17:25:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889425A33D;
	Wed, 12 Feb 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381104; cv=none; b=k40lGH0f6eR4IoTEmdP6XltkDCprXgapj4doslnv0b//7HfL5HnqIQOFZ6etoo9YZsbS7nngnrEPJNH1lgoQNgQRZpS5IB0UdnDWdEzjbajgzXsu8CSQfReTDscCErp7jsnsz/dFM43WDzk05dWEyJFGXHGm5U5KvOcT004hrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381104; c=relaxed/simple;
	bh=+nB1cPYHD/fxEy2WIZDTmBBHnFzDdf3ZrYDQGQawJII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de2rbvDqBW2Gb3kgeibMpH8WQqdQOwc0HnwIZk9s8LY/m8kn3S9MemWfvh1CwPPdMGZsUjo5HcmaXWN05ovUaG/ZCA1q8Wo0J/M5W2RaECEiPd/K+3ttUsfC2/4DwGYGOJwnp+1SnpPLFIF9vMn/88AEuPLIbsuyYNVYmlAcSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36236C4CEE2;
	Wed, 12 Feb 2025 17:25:01 +0000 (UTC)
Date: Wed, 12 Feb 2025 17:24:58 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yury Khrustalev <yury.khrustalev@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	nd@arm.com
Subject: Re: [RESEND v4 0/3] mm/pkey: Add PKEY_UNRESTRICTED macro
Message-ID: <Z6zZanGRGd15770_@arm.com>
References: <20250113170619.484698-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113170619.484698-1-yury.khrustalev@arm.com>

On Mon, Jan 13, 2025 at 05:06:16PM +0000, Yury Khrustalev wrote:
> Add PKEY_UNRESTRICTED macro to mman.h and use it in selftests.
> 
> For context, this change will also allow for more consistent update of the
> Glibc manual which in turn will help with introducing memory protection
> keys on AArch64 targets.
[...]
> Yury Khrustalev (3):
>   mm/pkey: Add PKEY_UNRESTRICTED macro
>   selftests/mm: Use PKEY_UNRESTRICTED macro
>   selftests/powerpc: Use PKEY_UNRESTRICTED macro
> 
>  include/uapi/asm-generic/mman-common.h               | 1 +
>  tools/testing/selftests/mm/mseal_test.c              | 6 +++---
>  tools/testing/selftests/mm/pkey-helpers.h            | 3 ++-
>  tools/testing/selftests/mm/pkey_sighandler_tests.c   | 4 ++--
>  tools/testing/selftests/mm/protection_keys.c         | 2 +-
>  tools/testing/selftests/powerpc/include/pkeys.h      | 2 +-
>  tools/testing/selftests/powerpc/mm/pkey_exec_prot.c  | 2 +-
>  tools/testing/selftests/powerpc/mm/pkey_siginfo.c    | 2 +-
>  tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 6 +++---
>  tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 6 +++---
>  10 files changed, 18 insertions(+), 16 deletions(-)

Andrew, Arnd - are you ok if I take these patches through the arm64
tree?

Thanks.

-- 
Catalin

