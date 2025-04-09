Return-Path: <linux-arch+bounces-11359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99383A829E0
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF7C16CBCF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Apr 2025 15:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B4268C66;
	Wed,  9 Apr 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Z6q0SJTi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09D268FC0;
	Wed,  9 Apr 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211413; cv=none; b=NAAoKO2GwhI3qrQ+oCEUltG4q6uABNdIrcworBxovrfVMK9BOUyry4GvdpA5Ye5ru3SzQ83JxO/YwUWl+cy4QJdmObds96x3L3bcHkiSaBUEsl9JBJGQ3YvHjWcfPAkeQT46Yvnltcs1WB+zp7wsZlsWeU1IYrlRqMV9L/hCnTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211413; c=relaxed/simple;
	bh=m+ileeI/S4SfHzwzecdVJy1uRBBuNSXPbhRf5YvqGVo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NE91/NTvRczIvhwrWIBoBM/1ysDFtnW4AkZx+5TzGG+y1Y90KxHB0QFO2sBFK+MisJDSCEvHlQO6d1aEA1zZTHJh9WHnaLYYAEGak1UWdqLWkvZKvvr2qinFyOyhn4jn1EbFyuyuf1xjQHbehah6rP3hE7tA7Av+lUWKByM4EmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Z6q0SJTi; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 539F9Qv53580146
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 9 Apr 2025 08:09:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 539F9Qv53580146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744211368;
	bh=S8R3ira7GiqR87Gqi7+fCSeOWuWG9c71+CUrPAR/wQY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Z6q0SJTiBDkXoc+m24O6DqZuWswRN68D7pnhCWEgs9Ms8N1rN7vw50nRqenz8zHJH
	 CYTNvmN0QR7467rzGfm0Tg5Ar5LVokSwcq6+J0UB/MPZKgf3gIQ31YocPaKxMo7Ou5
	 kCbH2o5p3ClZp7ucQgBHoJa486LLV+laPbKYDvIh4rC1FWdysoy5GO8B8Xo+f3EJCr
	 7eEQwdz+LBGwmgNUs6xlQo1wqTB7Q69Us8Mbty5lyU5+7iQJhKtWlHomWhYUWLt7DP
	 7LEy+mV84L79bwNZOOQKF5rlW0Ut3pKACM5OqCHb2nFowUiBIHEafo6M04Fq5Q5NJR
	 9k2ALNSQRohKQ==
Date: Wed, 09 Apr 2025 08:09:26 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, Jiri Slaby <jirislaby@kernel.org>
CC: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_6/6=5D_percpu/x86=3A_Enable_str?=
 =?US-ASCII?Q?ict_percpu_checks_via_named_AS_qualifiers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4YiYRhqu7mGWMN9pAsV-Nc6a97+EgiTCR34iaYDvXjDwQ@mail.gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com> <20250127160709.80604-7-ubizjak@gmail.com> <66e54eb9-58b3-4559-af32-66a77fe1ea01@kernel.org> <CAFULd4YiYRhqu7mGWMN9pAsV-Nc6a97+EgiTCR34iaYDvXjDwQ@mail.gmail.com>
Message-ID: <77B3F3ED-102D-4759-98F1-622629EBF9AF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 9, 2025 4:43:27 AM PDT, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Wed, Apr 9, 2025 at 1:07=E2=80=AFPM Jiri Slaby <jirislaby@kernel=2Eorg=
> wrote:
>>
>> On 27=2E 01=2E 25, 17:05, Uros Bizjak wrote:
>> > This patch declares percpu variables in __seg_gs/__seg_fs named AS
>> > and keeps them named AS qualified until they are dereferenced with
>> > percpu accessor=2E This approach enables various compiler check
>> > for cross-namespace variable assignments=2E
>>
>> So this causes modpost to fail to version some symbols:
>>
>> > WARNING: modpost: EXPORT symbol "xen_vcpu_id" [vmlinux] version gener=
ation failed, symbol will not be versioned=2E
>> > Is "xen_vcpu_id" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "irq_stat" [vmlinux] version generati=
on failed, symbol will not be versioned=2E
>> > Is "irq_stat" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "fred_rsp0" [vmlinux] version generat=
ion failed, symbol will not be versioned=2E
>> > Is "fred_rsp0" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "cpu_dr7" [vmlinux] version generatio=
n failed, symbol will not be versioned=2E
>> > Is "cpu_dr7" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "cpu_tss_rw" [vmlinux] version genera=
tion failed, symbol will not be versioned=2E
>> > Is "cpu_tss_rw" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "__tss_limit_invalid" [vmlinux] versi=
on generation failed, symbol will not be versioned=2E
>> > Is "__tss_limit_invalid" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "irq_fpu_usable" [vmlinux] version ge=
neration failed, symbol will not be versioned=2E
>> > Is "irq_fpu_usable" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "cpu_info" [vmlinux] version generati=
on failed, symbol will not be versioned=2E
>> > Is "cpu_info" prototyped in <asm/asm-prototypes=2Eh>?
>> > WARNING: modpost: EXPORT symbol "gdt_page" [vmlinux] version generati=
on failed, symbol will not be versioned=2E
>> > Is "gdt_page" prototyped in <asm/asm-prototypes=2Eh>?
>>  > =2E=2E=2E
>>
>> That happens both with 6=2E15-rc1 and today's -next=2E Ideas?
>
>https://lore=2Ekernel=2Eorg/lkml/20250404102535=2E705090-1-ubizjak@gmail=
=2Ecom/
>
>Uros=2E
>

A lot of those seem to be things that definitely shouldn't be expected=2E=
=2E=2E

