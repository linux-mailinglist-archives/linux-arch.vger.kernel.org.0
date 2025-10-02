Return-Path: <linux-arch+bounces-13883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07EBB3CF1
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 13:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E493616FC90
	for <lists+linux-arch@lfdr.de>; Thu,  2 Oct 2025 11:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F13081D0;
	Thu,  2 Oct 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffWouqXJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D939C3101A6
	for <linux-arch@vger.kernel.org>; Thu,  2 Oct 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405582; cv=none; b=XnqV12+keJ2oDsnIg+QkoMzuMPow7PFwIvgEoEkctL6/ITHrPHJRvu+mzUVlqGxdIdjR/1kTXYS3EZ2CJneu5hk2mRRPhQXbEwFnonLFPTp/Kl/ykBUqM7UJc3hLvs60O2o0zYA7WClfdOmbCnMlvwS4n6Yh/MknkDTqKprhMMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405582; c=relaxed/simple;
	bh=XAW7j/GiCX4Ldk1pbIGoe/EzygOj7TZ3MCMZKOX1tCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=psWcUnhaCRJ0QQhQaLuKClw7iONQT505zK217EHVflVmtTUlQh797b0kWrtl+TMk/MWLutNm3gT4+M7rvl+UQfqIiBEWyi+lC9T1i+n+0khOkfSpeHNaCtUKNyun1VsraP0nFeOhSjcpwPbAB52vZJAuHErw2opegSM05dPRS6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffWouqXJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XAW7j/GiCX4Ldk1pbIGoe/EzygOj7TZ3MCMZKOX1tCA=;
	b=ffWouqXJ4YmNG8hnVktMLB2Lay/MS5QVGiGjSacR7SfPe99Vc8maSLlyoKvKVxXxVrAdiA
	bpgNUNBxji7SxK5ZhgBs+t7tMNm4T+RxGf52quB4QgKXfFBCauqqz/Cx293XBsqtGjQcEE
	Y/0T+RcTVOGU0sVopqQgRZzk2/ifcm0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-0ElKgZKKMTaiTW8-y-6wyw-1; Thu,
 02 Oct 2025 07:46:17 -0400
X-MC-Unique: 0ElKgZKKMTaiTW8-y-6wyw-1
X-Mimecast-MFC-AGG-ID: 0ElKgZKKMTaiTW8-y-6wyw_1759405572
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 494BD1956095;
	Thu,  2 Oct 2025 11:46:10 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.225])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83FCA300018D;
	Thu,  2 Oct 2025 11:45:51 +0000 (UTC)
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
In-Reply-To: <aNxsWYYnj22G5xuX@debug.ba.rivosinc.com> (Deepak Gupta's message
	of "Tue, 30 Sep 2025 16:48:41 -0700")
References: <f953ee7b-91b3-f6f5-6955-b4a138f16dbc@kernel.org>
	<20250926192919.349578-1-cmirabil@redhat.com>
	<aNbwNN_st4bxwdwx@debug.ba.rivosinc.com>
	<CABe3_aE4+06Um2x3e1D=M6Z1uX4wX8OjdcT48FueXRp+=KD=-w@mail.gmail.com>
	<aNcAela5tln5KTUI@debug.ba.rivosinc.com>
	<lhu3484i9en.fsf@oldenburg.str.redhat.com>
	<aNxsWYYnj22G5xuX@debug.ba.rivosinc.com>
Date: Thu, 02 Oct 2025 13:45:48 +0200
Message-ID: <lhuwm5dh6hf.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Deepak Gupta:

> On Tue, Sep 30, 2025 at 11:20:32AM +0200, Florian Weimer wrote:
>>* Deepak Gupta:
>>
>>> In case of shadow stack, it similar situation. If enabled compiler
>>> decides to insert sspush and sspopchk. They necessarily won't be
>>> prologue or epilogue but somewhere in function body as deemed fit by
>>> compiler, thus increasing the complexity of runtime patching.
>>>
>>> More so, here are wishing for kernel to do this patching for usermode
>>> vDSO when there is no guarantee of such of rest of usermode (which if
>>> was compiled with shadow stack would have faulted before vDSO's
>>> sspush/sspopchk if ran on pre-zimop hardware)
>>
>>I think this capability is desirable so that you can use a distribution
>>kernel during CFI userspace bringup.
>
> I didn't get it, can you elaborate more.
>
> Why having kernel carry two vDSO (one with shadow stack and one without) would
> be required to for CFI userspace bringup?
>
> If Distro is compiling for RVA23 CONFIG_RISCV_USERCFI has to be selected yes,
> kernel can have vDSO with shadow stack. Distro can light this option only when
> its compiling entire distro for RVA23.

I think it boils down to whether you want CFI bringup contributions from
people who do not want to or cannot build their own custom RVA23
kernels.

Another use case would be running container images with CFI on a
distribution kernel which supports pre-RVA23 hardware.

Thanks,
Florian


