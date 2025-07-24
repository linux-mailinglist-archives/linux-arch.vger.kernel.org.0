Return-Path: <linux-arch+bounces-12936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9AB10D4D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 16:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6357456148A
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CA32D8DC6;
	Thu, 24 Jul 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pwq5tdM2"
X-Original-To: linux-arch@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970CB4C81;
	Thu, 24 Jul 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366422; cv=none; b=bwGVwBlaLzfSqth9D2+Ck/FjQB+R2VelZuQhJXTngNU32Li3pNwvjYwuPyCMGirFGo5M5O/AnAArXpKkADdOjwcGm2WH3/nvk9N3jU8FBzfyTv6g7miNEvO7ZsgCJC0rIBRQS8vQGgklOWEhSdhoPSCHBIr8uRHJZWkfhWDj5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366422; c=relaxed/simple;
	bh=uYaq9vVkbSUr+tB940oFmDR9L9mTXUEkazEXEditOQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bh+sCBkZnXHrNkFI9nBBc7q+IzO4gx59UoupZp/dt2ufqXyeug6RiZvBk47YbYjtJMm31UFdAssXkuOON3uOEK0+BQ+4ub/ORScll0Q43aFoS1E0XM7AyV3lO5kPVlzBpDSgbqx/9P+37/CVfkHYXDS1Oxkbf1N1APtpeWtdjgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pwq5tdM2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3A3B040AD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1753366414; bh=FDYBYXhi2fpIXmidMih0lla5P8/HwKyQKaeA3qjglN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pwq5tdM2vDY6APoBJuNEplILNdsyaU8ylKRxeCbXe8XwZITdA49KYYVSYTry8HpKV
	 11JU1pkrDwmKYTn4Fl/PSS7PRD9lEUq9GYeo/HlJaKcFNthhWNgGaSbErWZpRksXU/
	 2vcUlKH47OM35KhDFiJKYjv9eHZYQfJhlwveoisq76XE1Ph/wNujQEY4mwi+2EPI03
	 C6Ge6wReBlahOFy06igmvLpUfGmMHNmMAtE5bIWSddnTvAo8pP5gNfRizJLIkJVMoq
	 n+gO3mVS2lc+fqlOMygB0N/vI5gck9MYQxuB1GcL+iBGKHLpcflufHKZM8r4X1ng6W
	 uqNwh/ttjzzkw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3A3B040AD2;
	Thu, 24 Jul 2025 14:13:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 eugen.hristev@linaro.org, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
Subject: Re: [RFC][PATCH v2 02/29] Documentation: add kmemdump
In-Reply-To: <20250724135512.518487-3-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-3-eugen.hristev@linaro.org>
Date: Thu, 24 Jul 2025 08:13:33 -0600
Message-ID: <87zfctad82.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eugen Hristev <eugen.hristev@linaro.org> writes:

> Document the new kmemdump kernel feature.

Thanks for including documentation!

> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
> ---
>  Documentation/debug/index.rst    | 17 ++++++
>  Documentation/debug/kmemdump.rst | 98 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                      |  1 +
>  3 files changed, 116 insertions(+)
>  create mode 100644 Documentation/debug/index.rst
>  create mode 100644 Documentation/debug/kmemdump.rst
>
> diff --git a/Documentation/debug/index.rst b/Documentation/debug/index.rst
> new file mode 100644
> index 000000000000..9a9365c62f02
> --- /dev/null
> +++ b/Documentation/debug/index.rst
> @@ -0,0 +1,17 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===
> +kmemdump
> +===
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   kmemdump
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`

Please don't create a new top-level directory for just this tool - I've
been working for years to get Documentation/ under control.  This seems
best placed under Documentation/dev-tools/ ?


> diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
> new file mode 100644
> index 000000000000..3301abcaed7e
> --- /dev/null
> +++ b/Documentation/debug/kmemdump.rst
> @@ -0,0 +1,98 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
> +kmemdump
> +==========================

A nit, but it's nicer to match the markup line lengths with the enclosed
text. 

> +This document provides information about the kmemdump feature.
> +
> +Overview
> +========
> +
> +kmemdump is a mechanism that allows any driver or producer to register a
> +chunk of memory into kmemdump, to be used at a later time for a specific
> +purpose like debugging or memory dumping.
> +
> +kmemdump allows a backend to be connected, this backend interfaces a
> +specific hardware that can debug or dump the memory registered into
> +kmemdump.
> +
> +kmemdump Internals
> +=============
> +
> +API
> +----
> +
> +A memory region is being registered with a call to `kmemdump_register` which

Please just say kmemdump_register() - that will let our carefully
written automatic markup machinery do its thing.  Among other things, it
will create a cross-reference link to the kerneldoc documentation for
this function (if any).  All function references should be written that
way. 

> +takes as parameters the ID of the region, a pointer to the virtual memory
> +start address and the size. If successful, this call returns an unique ID for
> +the allocated zone (either the requested ID or an allocated ID).
> +IDs are predefined in the kmemdump header. A second registration with the
> +same ID is not allowed, the caller needs to deregister first.
> +A dedicated NO_ID is defined, which has kmemdump allocate a new unique ID
> +for the request and return it. This case is useful with multiple dynamic
> +loop allocations where ID is not significant.
> +
> +The region would be registered with a call to `kmemdump_unregister` which
> +takes the id as a parameter.
> +
> +For dynamically allocated memory, kmemdump defines a variety of wrappers
> +on top of allocation functions which are given as parameters.
> +This makes the dynamic allocation easy to use without additional calls
> +to registration functions. However kmemdump still exposes the register API
> +for cases where it may be needed (e.g. size is not exactly known at allocation
> +time).
> +
> +For static variables, a variety of annotation macros are provided. These
> +macros will create an annotation struct inside a separate section.
> +
> +
> +Backend
> +-------
> +
> +Backend is represented by a `struct kmemdump_backend` which has to be filled

Structures, too, can be mentioned without explicit markup.

> +in by the backend driver. Further, this struct is being passed to kmemdump
> +with a `backend_register` call. `backend_unregister` will remove the backend
> +from kmemdump.
> +
> +Once a backend is being registered, all previously registered regions are
> +being sent to the backend for registration.
> +
> +When the backend is being removed, all regions are being first deregistered
> +from the backend.
> +
> +kmemdump will request the backend to register a region with `register_region`
> +call, and deregister a region with `unregister_region` call. These two
> +functions are mandatory to be provided by a backend at registration time.
> +
> +Data structures
> +---------------
> +
> +`struct kmemdump_backend` represents the kmemdump backend and it has two
> +function pointers, one called `register_region` and the other
> +`unregister_region`.
> +There is a default backend that does a no-op that is initially registered
> +and is registered back if the current working backend is being removed.

Rather than this sort of handwavy description, why not just use the
kerneldoc comments you have written for this structure?

> +The regions are being stored in a simple fixed size array. It avoids
> +memory allocation overhead. This is not performance critical nor does
> +allocating a few hundred entries create a memory consumption problem.
> +
> +The static variables registered into kmemdump are being annotated into
> +a dedicated `.kemdump` memory section. This is then walked by kmemdump
> +at a later time and each variable is registered.
> +
> +kmemdump Initialization
> +------------------
> +
> +After system boots, kmemdump will be ready to accept region registration
> +from producer drivers. Even if the backend may not be registered yet,
> +there is a default no-op backend that is registered. At any time the backend
> +can be changed with a real backend in which case all regions are being
> +registered to the new backend.
> +
> +backend functionality
> +-----------------
> +
> +kmemdump backend can keep it's own list of regions and use the specific
> +hardware available to dump the memory regions or use them for debugging.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e8da575025c..ef0ffdfaf3de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13620,6 +13620,7 @@ F:	drivers/iio/accel/kionix-kx022a*
>  KMEMDUMP
>  M:	Eugen Hristev <eugen.hristev@linaro.org>
>  S:	Maintained
> +F:	Documentation/debug/kmemdump.rst
>  F:	drivers/debug/kmemdump.c
>  F:	include/linux/kmemdump.h

Thanks,

jon

