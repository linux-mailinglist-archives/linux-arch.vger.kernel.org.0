Return-Path: <linux-arch+bounces-5344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22992CF89
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9E71C2173E
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35561922F9;
	Wed, 10 Jul 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioCbpULW"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DAE19004E
	for <linux-arch@vger.kernel.org>; Wed, 10 Jul 2024 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607807; cv=none; b=TyOxEazAUbPFXNplEHi41xCEVXWxOahAd3tAFxcN2+Npm7hhr/IsvN25N+nySpsJ2Ygpu7B4HPjY6fENsr+kIn13Q++dBHuWbtZi1O3XDXJI1vMY5gyo4qbRpAtvHZ53WfZrYfsCSnscT8UduI77mi48Vo9ZR/ddz9bbsIVjIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607807; c=relaxed/simple;
	bh=kqLm5P45NxwgK+tmNpa+OcNHo84diEsXJjayzggqo7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PJm8JK/UVGjyYl/W6bpSDW6xJ73Wnpb1tzPBZXZQMo+0T/b/vTR9HEGRmge6iKY3qV/3zOzb09cM3b9sAG5KP7AMQDiO1Is+2rbubIPWDkeB2/m/EiCNgemgABEn8zoF+m3X5uhJGqzDFXozQx+uGXtW13KXp2oVJ9MYFg6EKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioCbpULW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720607805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbJg6z7j+ZQBtm21UhpDM4r/48rTnLX4yDmOeuhoEeA=;
	b=ioCbpULWxtfoe8brH+B0h725MLz9J3f1YwRnkeg55GktTbmjIAMkLe+Oiv6ZWaanrUeUOs
	+w/kV6qs2agoAiO+t52GqJW1pI7Amct2wLz4uXZoT2y2zXrJDAkes/01V7m+gehj0gpJ9t
	8fy7lvwbxN8TBdeTnw29gqXskfxfA2Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-a07wZjSjMfOCkc_bgrfTiQ-1; Wed,
 10 Jul 2024 06:36:41 -0400
X-MC-Unique: a07wZjSjMfOCkc_bgrfTiQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07722196CE01;
	Wed, 10 Jul 2024 10:36:36 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.154])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A378D19560AE;
	Wed, 10 Jul 2024 10:36:24 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Christian Brauner
 <brauner@kernel.org>,  Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>,  Ross Burton <ross.burton@arm.com>,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  kvmarm@lists.linux.dev,  linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, "Schimpe, Christina"
 <christina.schimpe@intel.com>, "Pandey, Sunil K"
 <sunil.k.pandey@intel.com>
Subject: Re: [PATCH v9 05/39] arm64/gcs: Document the ABI for Guarded
 Control Stacks
In-Reply-To: <20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org> (Mark Brown's
	message of "Tue, 25 Jun 2024 15:57:33 +0100")
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-5-0f634469b8f0@kernel.org>
Date: Wed, 10 Jul 2024 12:36:21 +0200
Message-ID: <87a5iph6u2.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Mark Brown:


> +4.  Signal handling
> +--------------------
> +
> +* A new signal frame record gcs_context encodes the current GCS mode and
> +  pointer for the interrupted context on signal delivery.  This will always
> +  be present on systems that support GCS.
> +
> +* The record contains a flag field which reports the current GCS configuration
> +  for the interrupted context as PR_GET_SHADOW_STACK_STATUS would.
> +
> +* The signal handler is run with the same GCS configuration as the interrupted
> +  context.
> +
> +* When GCS is enabled for the interrupted thread a signal handling specific
> +  GCS cap token will be written to the GCS, this is an architectural GCS cap
> +  token with bit 63 set and the token type (bits 0..11) all clear.  The
> +  GCSPR_EL0 reported in the signal frame will point to this cap token.

How does this marker interfere with Top Byte Ignore (TBI; I hope I got
the name right)?  The specification currently does not say that only
addresses pushed to the shadow stack with the top byte cleared, which
potentially makes the markup ambiguous.  On x86-64, the same issue may
exist with LAM.  I have not tested yet what happens there.  On AArch64
and RISC-V, it may be more natural to use the LSB instead of the LSB for
the mark bit because of its instruction alignment.

We also have a gap on x86-64 for backtrace generation because the
interrupted instruction address does not end up on the shadow stack.
This address is potentially quite interesting for backtrace generation.
I assume it's currently missing because the kernel does not resume
execution using a regular return instruction.  It would be really useful
if it could be pushed to the shadow stack, or recoverable from the
shadow stack in some other way (e.g., the address of the signal context
could be pushed instead).  That would need some form of marker as well.

Thanks,
Florian


