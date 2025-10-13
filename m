Return-Path: <linux-arch+bounces-14043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 425DABD384E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A048189ED91
	for <lists+linux-arch@lfdr.de>; Mon, 13 Oct 2025 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E47244679;
	Mon, 13 Oct 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USDXVyCI"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C63221FCB
	for <linux-arch@vger.kernel.org>; Mon, 13 Oct 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365845; cv=none; b=DtVqPYxK4qa7b4iylsqan69yuZNB6eXg8ClfLFC4LFhWhp/Wj9ea2tAU0rkJ6Olw6wsy7fs6zkIWcgJ1/V2uBPgpwGJqwTFujLsegb1zjEUpOiRS9DJC5ZA0HvJZrOrDopRQhV1/aMh0VqdSf/rMvB3ZyghDFr1yXCivFQZbStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365845; c=relaxed/simple;
	bh=p7OPEdJE5ToR35hajbcxBsZGseYV7ErRLMU40tXYi4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rP08FKTRkrAJzh7ETycx+SJH13JwEII2Db6d1Lh3NpJj6msa5xlKBoZuMn1c0kcyDfIDWk5UMHHaUACoyGAt5p8EdIKpsjxd3dPue9gAKQImg3xLxlkjPREVicaWXfPGf72zjmTgAn1Rf28UmtjOVPqjosLLI5/L9Oc9KBQnRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USDXVyCI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760365842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTlu2d/OCa7smgTdfnf6rps6xmzbDobGt8v/NuBgfVM=;
	b=USDXVyCI1oHzHhJx940Mf5G5w3g/qYVZP4qIK1Gp/c10/5wpfMTKP2gDvhwZfXcdR+kQ/y
	YpgA/UfKZJB1vxm/eepm4Z+W4YmFIViZMfRXJj2PzqoAszTFfjduBmEPxr8plMr3c1r4XV
	5YPChx3jFFQqEfunEnO6Eqs2wDEHG/g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-WHoEOy0QNoS_DHwHLaA70A-1; Mon,
 13 Oct 2025 10:30:37 -0400
X-MC-Unique: WHoEOy0QNoS_DHwHLaA70A-1
X-Mimecast-MFC-AGG-ID: WHoEOy0QNoS_DHwHLaA70A_1760365832
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAB3019560A7;
	Mon, 13 Oct 2025 14:30:29 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 414E01954107;
	Mon, 13 Oct 2025 14:30:12 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: Charles Mirabile <cmirabil@redhat.com>,  pjw@kernel.org,
  Liam.Howlett@oracle.com,  a.hindborg@kernel.org,
  akpm@linux-foundation.org,  alex.gaynor@gmail.com,
  alexghiti@rivosinc.com,  aliceryhl@google.com,  alistair.francis@wdc.com,
  andybnac@gmail.com,  aou@eecs.berkeley.edu,  arnd@arndb.de,
  atishp@rivosinc.com,  bjorn3_gh@protonmail.com,  boqun.feng@gmail.com,
  bp@alien8.de,  brauner@kernel.org,  broonie@kernel.org,
  charlie@rivosinc.com,  cleger@rivosinc.com,  conor+dt@kernel.org,
  conor@kernel.org,  corbet@lwn.net,  dave.hansen@linux.intel.com,
  david@redhat.com,  devicetree@vger.kernel.org,  ebiederm@xmission.com,
  evan@rivosinc.com,  gary@garyguo.net,  hpa@zytor.com,  jannh@google.com,
  jim.shu@sifive.com,  kees@kernel.org,  kito.cheng@sifive.com,
  krzk+dt@kernel.org,  linux-arch@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  linux-riscv@lists.infradead.org,
  lorenzo.stoakes@oracle.com,  lossin@kernel.org,  mingo@redhat.com,
  ojeda@kernel.org,  oleg@redhat.com,  palmer@dabbelt.com,
  paul.walmsley@sifive.com,  peterz@infradead.org,
  richard.henderson@linaro.org,  rick.p.edgecombe@intel.com,
  robh@kernel.org,  rust-for-linux@vger.kernel.org,
  samitolvanen@google.com,  shuah@kernel.org,  tglx@linutronix.de,
  tmgross@umich.edu,  vbabka@suse.cz,  x86@kernel.org,  zong.li@sifive.com
Subject: Re: [PATCH v19 00/27] riscv control-flow integrity for usermode
In-Reply-To: <aN6sNFBzx8NPU3Th@debug.ba.rivosinc.com> (Deepak Gupta's message
	of "Thu, 2 Oct 2025 09:45:40 -0700")
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
	<20250926192919.349578-1-cmirabil@redhat.com>
	<aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
	<CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
	<aNcAela5tln5KTUI@debug.ba.rivosinc.com>
	<lhu3484i9en.fsf@oldenburg.str.redhat.com>
	<aNxsWYYnj22G5xuX@debug.ba.rivosinc.com>
	<lhuwm5dh6hf.fsf@oldenburg.str.redhat.com>
	<aN6sNFBzx8NPU3Th@debug.ba.rivosinc.com>
Date: Mon, 13 Oct 2025 16:30:09 +0200
Message-ID: <lhujz0yoowe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Deepak Gupta:

> How will they contribute to CFI bringup without having a CFI compiled
> usersapce?

Build glibc themselves and then proceed one library at the time.

>>Another use case would be running container images with CFI on a
>>distribution kernel which supports pre-RVA23 hardware.
>
> Container image with CFI will have glibc and ld (and all other
> userspace) also compiled with shadow stack instructions in it. As soon
> as you take this container image to a pre-RVA23 hardware, you won't
> even reach vDSO. It'll break much before that, unless kernel is taking
> a trap on all sspush/sspopchk instructions in prologue/epilogue of
> functions in userspace (glibc, ld, etc)

The idea is that you can use a stock distribution kernel to run CFI
images (potentially form a different distribution or version of the
distribution).

But maybe none of this really matters.  How far out is CFI-checking
hardware?  Is it going to arrive much later than the RVA23 flag day
that people are suggesting?

Thanks,
Florian


