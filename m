Return-Path: <linux-arch+bounces-12156-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C407BAC91B9
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 16:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA103A51AA
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D8F232395;
	Fri, 30 May 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrC+rp7y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF53212B2F
	for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616100; cv=none; b=pQEgIbR7+0cAfYdf+mlDuMhr2grf7xnqmRgWG9o+FuVDxYc18MHadmL2/F5B9S2G4R5GGC/maLRhyMm0PTjpfCRh9KStMpREQuGjZBqjTQiq64edbtW11NgUWoS6wu9YmGNHWf4lK2HHKWnoIPoVX6LAy51HzSwEEMYeMN0qvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616100; c=relaxed/simple;
	bh=FKW1st2NJc9lopvX5QiY1Tuw4jpZJpc7kvb4kkmbBZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOk6jvepS4Y1GhdTdcH4p3/u9aeiXuoo+/QPHUOCLn5+OW2+K86ky1Gj2qDNCRqMz+mthTuFa+ro3HXEqE4Lj5L2cjFfG7oJ5mcOMY0+RT/4F2XrQ5NEDP39LFvQawGkPmAQtwS94RUVBh7gt5nPM3obSzHNZYTVeCi5MOvPUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrC+rp7y; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so9407a12.1
        for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748616097; x=1749220897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKW1st2NJc9lopvX5QiY1Tuw4jpZJpc7kvb4kkmbBZ4=;
        b=VrC+rp7ysJfstXBBAQMCQuVoY7eSFZRNo2ULwB/+E424PsIzMiq4gG+RXkVeAZs5l0
         LV3tIPiHKpXcEgyYO2gNjuwSkw0DiCOfCrOjcSC7eYSoLa0IWUUgYRBlTGUAOURCldW1
         ecyoEv6pNGRNOvRUkqXD2ay7kQTzqgtLSppVUBtyGFll7fUh4iS40PQfs6qsoBiTeY2B
         YHH+/ZHkYLAC8RBYGGjzxo2C35M+jZzJ0BpOu4S2JepjXRrlP6/RHdWLRawbCAhqq4IU
         QO8LOE2H20YWCBKFs9nbuB/TscqZenJSl43uRatBFAQq2ZRCK9EVVjCk26mUMw5sqQZ8
         Px0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748616097; x=1749220897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKW1st2NJc9lopvX5QiY1Tuw4jpZJpc7kvb4kkmbBZ4=;
        b=iU/nUBQuzhUSn1c8/M6a4IDzu28+P0WQrliG5q3h/ioOh3vEQ6pGA4B1nfiAQ1HytJ
         AKF5tph4Fn43bMOjj//zsj0SyIy5Tj/cJ0mT9MLBKDQsc0+pOIaC7zVMHa9khOVTIB3H
         CnNIsTsBs0YrGFbe7fNCNnQIWBLeJdjff9PiIVXz85TklbCRZ37cVrDagKzJbZ+bG5T4
         aaV3JbqtGV4VOKGiGyH9s0jpoTZtqg6LoTYdJBnaNKYZvANGT54ta+YOI+OsC9Cwk4yu
         cimMBv19d38dc9xQsp97cK9RrUN+2XtBZiWPbRwYqey09ZGqEQj0MmOaa3umvKiipbWi
         wV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeCgYUDyGcu3jbvROrokroArqp5Vts64vSS/gRzK8GeQwq0uAQI10tUP5IR9v5SdR6wC9RHFiUp6eg@vger.kernel.org
X-Gm-Message-State: AOJu0YyTffTEb0vudlonRmGtxElKItINr9ft9Y7gqAmsN19JBrG0M44i
	aiym2V3Clp28+TicnYnnRoETdt04KwZPrYYKSTn5AahDb7KgHW42mj8YsyrVvE39S+Te/7tJhhW
	QajXVlLopr+XlJNuvwUQn47nSrdjZDY/KQ2E5gHAL
X-Gm-Gg: ASbGncsTN/kGdY+09XjKcy8sq7p/1RV2f+pgirLQ6zrVQ/HTnHZF7JqgCBkaRXlbxDV
	j1+aqFXBM2oEh46ljRnQe3mmdmTPGoH4I8WD1ugk6NUEG3ds/H1pmaZYK+LIKo3AQ5gLNRc0/Q8
	ePJLp2/aLSu2kFC37Ig17XmNQzsy/S+OoC7QUynCzSMNdn+Bdkv/vrygxZ8Kn0vvp1GeKsg8s=
X-Google-Smtp-Source: AGHT+IHfSAH1Rt5ln6NCIiDOW0+Td25WW+i2unl+C03KBiv5EQFnOViGfDfDNBXh722+FKNL1nhlyFP/h67WwEKTknc=
X-Received: by 2002:a50:9993:0:b0:605:6567:818 with SMTP id
 4fb4d7f45d1cf-60577a56d86mr80548a12.5.1748616096994; Fri, 30 May 2025
 07:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404021902.48863-1-anthony.yznaga@oracle.com> <20250404021902.48863-9-anthony.yznaga@oracle.com>
In-Reply-To: <20250404021902.48863-9-anthony.yznaga@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 16:41:00 +0200
X-Gm-Features: AX0GCFvUNLf3RD2IVMPPhCiy_e0p5MPXFHQagt1uA4fg4sf6dY9DDshf7MBKECg
Message-ID: <CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com>
Subject: Re: [PATCH v2 08/20] mm/mshare: flush all TLBs when updating PTEs in
 an mshare range
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 4:18=E2=80=AFAM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
> Unlike the mm of a task, an mshare host mm is not updated on context
> switch. In particular this means that mm_cpumask is never updated
> which results in TLB flushes for updates to mshare PTEs only being
> done on the local CPU. To ensure entries are flushed for non-local
> TLBs, set up an mmu notifier on the mshare mm and use the
> .arch_invalidate_secondary_tlbs callback to flush all TLBs.
> arch_invalidate_secondary_tlbs guarantees that TLB entries will be
> flushed before pages are freed when unmapping pages in an mshare region.

Thanks for working on this, I think this is a really nice feature.

An issue that I think this series doesn't address is:
There could be mmu_notifiers (for things like KVM or SVA IOMMU) that
want to be notified on changes to an mshare VMA; if those are not
invoked, we could get UAF of page contents. So either we propagate MMU
notifier invocations in the host mm into the mshare regions that use
it, or we'd have to somehow prevent a process from using MMU notifiers
and mshare at the same time.

