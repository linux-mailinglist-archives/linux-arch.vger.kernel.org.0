Return-Path: <linux-arch+bounces-1732-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3496083E302
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 21:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE1E2876B7
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C1722F17;
	Fri, 26 Jan 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMWxv2La"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363ED22F11
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299252; cv=none; b=CV1qPyHvYZJ/P+A41QkvtA3815Ke4V7xXbVYh9p1KRy4opRPEb5MhECjm6etiN/pIRT4LBauFtvXMFsM/a78l/aDn/5bpF6dtpQPuQI7qLrePwKmuNIDnFS3Iz864A+My7vMT7FdvvGKTpaaC0ynJY1PNlHXYdkBrHIaj9/jERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299252; c=relaxed/simple;
	bh=fcxQ3bc2/ycZVVRavVndN2TW1bmrjhqtW752nshgov4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHD87IkFRKMVMfARFIDVIUpZC1cJEvbPlhV4wUqqVmanmHmWApNAvP464OdjJQQXQgdhA0+146g/Gz/VJUU+AEqh5nznPlQ39G2uvXMk1hjmkMwQATiy9/hMvO0F5J5S442PK5XLMZkNzgLAqWrfLo3F+8YxGm+gR6nF4tmDFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMWxv2La; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d76f1e3e85so22675ad.0
        for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706299250; x=1706904050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MimXWUdcIvN0nH3+dB3+knWCETvDzwsFYg6Za1niF5A=;
        b=YMWxv2LaOd1dcfqzupCcwMB+CtjBdtFEUGJpYmamncMy6fKsXW0Pu9UsOeA2A0nA7m
         awROwFafV0KwQC4whgnD5xgIlVL6+WIlHXiq8Lg34EpAlTJUqRzYeubb9gEBR4GZzVVD
         V7EkNkJoK2HfHltFPpNivyhioX4CbuUO8mNUOjLtrzKiBSsS/Cy2UZEpA1z4EA1iyNpU
         X0giY/smB78dF2ZLkSBGGu7S35WA1DhtFf/9pZpswzRWDmzt6pmlkpd9X2vXu8E/1Uu7
         BFStjW4ngBX2zwBWlpmFq9ciWL3KFpuov4e/cEuHpwdHruCSMmsInYIoGeTSzomm+0ZW
         Y4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299250; x=1706904050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MimXWUdcIvN0nH3+dB3+knWCETvDzwsFYg6Za1niF5A=;
        b=fS+upJqOsQkw+d/zy5jQSbj2gRxZQM0Ct37WDQo9/7F7rMvWNq+dCnPTg07QW2zF82
         FwSvtYv8YYbORL5iPS/qHpFyxtFpuD9Oe63HgW1Zp+729A9lg3wO3evKWNqwJJVooGRi
         ghRkt8kXbaDmds82w+TA5mku8WYnox9WBUG3L8T0+U53E/4GO1g5GN9GWEgT6thDynhm
         jWoR5ToOK6NbllTefeaPPE9XP2jedHEttmeb9yp6OG0ZEwq57PvTacj5IrUWyvtyBMJG
         YUFp6APMrpBh/wDUiOqGrZpB2I5t4CkIrLV9tAI45VeJrK0gQEIvJno8MK6dLiAXLnXV
         STxg==
X-Gm-Message-State: AOJu0Yz0vGGJ/P4vTl75fjzeha79vphP9sReGi1WG4FXZHfNCbDYgvyp
	p/ZH4emPeidSlPlBuiUM0Bk51gW+xJf5Hj10PjasfGuwF7ekVf/CFzWdBgj3jGtdQj5MGHBgWcL
	I5VnEFYPxL7/zdTFGsWc6b/YsJ7j43R+JvE8c
X-Google-Smtp-Source: AGHT+IFUiaxxx/fnNfe3njsMipgqF2fdYzG/YBwFDzOMI+2YRba8r80bUR3upqDy6QVJlcre5NJrJ1mYmBGhuhzNf/E=
X-Received: by 2002:a17:903:1246:b0:1d8:a782:6cc2 with SMTP id
 u6-20020a170903124600b001d8a7826cc2mr127996plh.13.1706299249979; Fri, 26 Jan
 2024 12:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com> <20240125164256.4147-12-alexandru.elisei@arm.com>
In-Reply-To: <20240125164256.4147-12-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 26 Jan 2024 12:00:36 -0800
Message-ID: <CAMn1gO6hx7yaFHEYVbkpPocAxQmQc3JBgppcNSJw9SUfyvjwbQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio
 allocation when VMA is known
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, steven.price@arm.com, 
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com, 
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:43=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
> When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
> the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
> set in vma_alloc_zeroed_movable_folio().
>
> Expand this to be more generic by adding an arch hook that modifes the gf=
p
> flags for an allocation when the VMA is known.
>
> Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZE=
RO
> is also set; from that point of view, the current behaviour is unchanged,
> even though the arm64 flag is set in more places.  When arm64 will have
> support to reuse the tag storage for data allocation, the uses of the
> __GFP_ZEROTAGS flag will be expanded to instruct the page allocator to tr=
y
> to reserve the corresponding tag storage for the pages being allocated.
>
> The flags returned by arch_calc_vma_gfp() are or'ed with the flags set by
> the caller; this has been done to keep an architecture from modifying the
> flags already set by the core memory management code; this is similar to
> how do_mmap() -> calc_vm_flag_bits() -> arch_calc_vm_flag_bits() has been
> implemented. This can be revisited in the future if there's a need to do
> so.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

This patch also needs to update the non-CONFIG_NUMA definition of
vma_alloc_folio in include/linux/gfp.h to call arch_calc_vma_gfp. See:
https://r.android.com/2849146

Peter

