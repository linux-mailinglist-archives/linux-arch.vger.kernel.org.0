Return-Path: <linux-arch+bounces-721-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C467B80784E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 20:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A011F211A0
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081639FF5;
	Wed,  6 Dec 2023 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS8F1Nji"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E565B193;
	Wed,  6 Dec 2023 11:00:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-286e676ffa0so152592a91.1;
        Wed, 06 Dec 2023 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701889229; x=1702494029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzbohbzVePtQAWojGFBvS0mVM42OxJTLPxt60AU1LYc=;
        b=FS8F1NjiwZT8FmM7L617gO7Pg9H/a9IsBa6ryAYBD4jiO1WTUnSvyUckmdGBum8KoU
         BQqzUl4X+XiSavCZD23wmdSBkZm40X2ifg5//zD7HOgc5oS3dgr11nD2i6aAHCSkQ+AI
         O4YYx9bJ6tQbEETsnEVL2KE31GE3XOPPj5Wh5f2BFiQDYLIWPUEjwxUBOzIEovyxUGP/
         HbaNsnwVVpLZXgydQAzGyYLOaieeVRDG6Hb6KTLgCymnFYQH627ESJzTxzTaRptwUATm
         mwyCNoSQbKP9Txzuls6Cn83PCzzeyHAK287RZOOI+L0VIS/vwQ+OiQ9MH/A1SE20JJEF
         qfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701889229; x=1702494029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzbohbzVePtQAWojGFBvS0mVM42OxJTLPxt60AU1LYc=;
        b=J3yDwY4OM8LEWo4JMseQp1VFQIAHnGPuKUczxobyEXiBqXq6vTzMktKGSuybmTzmOY
         tz1WrLnEhH4S+tPh7EyK/wHJBhDknBM49i06Y76uD8KvCnU84CAjM+dA505T6fH0MCDi
         THm/G42Zqr5ot8bakN2AqCVQTdLZglEGTZa00hfyjVRN1+qEjTAELdQepC5ivMbliH66
         ++EX1u3raIz1Putgyr99oCVuTJZX8NYLykTMVmkPUpVYEBWsICmfz2/2K0hS5MqHDLq0
         pxVzpLgKLP8lXl4jYjOKBD87US5pSCic14Y3iRpknjVIS+7lFAg9oKA5rudG3mBkwF19
         WDUg==
X-Gm-Message-State: AOJu0YxvZWL9mmz1co0FluPCZO4CgleudRJCBRunVeje4IRT1nxM7Sgw
	bkZGni4YHUO0/UtYY/vDTc4=
X-Google-Smtp-Source: AGHT+IGt2RkwoEJvnNo596uficEOJHOXr2g3TtQ4DOJL5NzM/DY50pjdwYSQUW8PI8sB4O4FfCwApg==
X-Received: by 2002:a17:90b:38c5:b0:286:aded:d5de with SMTP id nn5-20020a17090b38c500b00286adedd5demr1064920pjb.15.1701889229200;
        Wed, 06 Dec 2023 11:00:29 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709027b8400b001d049cc4c9asm169921pll.7.2023.12.06.11.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:00:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 6 Dec 2023 09:00:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/2] riscv: Enable percpu page first chunk allocator
Message-ID: <ZXDEyzVcBOPUCCpg@slm.duckdns.org>
References: <20231110140721.114235-1-alexghiti@rivosinc.com>
 <f259088f-a590-454e-b322-397e63071155@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f259088f-a590-454e-b322-397e63071155@ghiti.fr>

On Wed, Dec 06, 2023 at 11:08:20AM +0100, Alexandre Ghiti wrote:
> Hi Tejun,
> 
> On 10/11/2023 15:07, Alexandre Ghiti wrote:
> > While working with pcpu variables, I noticed that riscv did not support
> > first chunk allocation in the vmalloc area which may be needed as a fallback
> > in case of a sparse NUMA configuration.
> > 
> > patch 1 starts by introducing a new function flush_cache_vmap_early() which
> > is needed since a new vmalloc mapping is established and directly accessed:
> > on riscv, this would likely fail in case of a reordered access or if the
> > uarch caches invalid entries in TLB.
> > 
> > patch 2 simply enables the page percpu first chunk allocator in riscv.
> > 
> > Alexandre Ghiti (2):
> >    mm: Introduce flush_cache_vmap_early() and its riscv implementation
> >    riscv: Enable pcpu page first chunk allocator
> > 
> >   arch/riscv/Kconfig                  | 2 ++
> >   arch/riscv/include/asm/cacheflush.h | 3 ++-
> >   arch/riscv/include/asm/tlbflush.h   | 2 ++
> >   arch/riscv/mm/kasan_init.c          | 8 ++++++++
> >   arch/riscv/mm/tlbflush.c            | 5 +++++
> >   include/asm-generic/cacheflush.h    | 6 ++++++
> >   mm/percpu.c                         | 8 +-------
> >   7 files changed, 26 insertions(+), 8 deletions(-)
> > 
> 
> Any feedback regarding this?

On cursory look, it looked fine to me but Dennis is maintaining the percpu
tree now. Dennis?

Thanks.

-- 
tejun

