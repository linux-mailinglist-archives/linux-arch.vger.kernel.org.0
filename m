Return-Path: <linux-arch+bounces-9841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A6AA1826E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EDA188BE61
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jan 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4171F1F55F5;
	Tue, 21 Jan 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMVW1OpN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D721F55E4;
	Tue, 21 Jan 2025 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737478819; cv=none; b=kVk0KzAUjxT9JHFl1p7PAgyXFfbvVkaDgktbM62nrbIhUTLv/QB7lVmwT6o+JylJoJNS7IIV5ZR7NYL4WILayQKhaksGea9OytSPu78pCmuVR5JbJ2VqrQJy2+sBMb06pNat9Yo29YqJg24qDdbuJPGwPlA38wUjR3jkVxotA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737478819; c=relaxed/simple;
	bh=9OS+xRmfz4uuv2J1YGJZ++S2O40MMdmWQmSQIuypaCI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU+abS1bGf7dYKs1ummvugRXTGAWYmpb4L8WEkGY2CbbQm3LdPJEq6cdSBvxNBO4ZdxduDBXeKTr4SSpfG2unbKtwUOTx1qb0oFeUi1lbLS9GmO3czfQftoFs8CiMaHLQXsoGhyhwfvFhvQVuwWs1rso6P5B6RnAEy2eC69ptsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMVW1OpN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54021daa6cbso6474898e87.0;
        Tue, 21 Jan 2025 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737478814; x=1738083614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6O7kZyVX02YaNVvlK+AnjIGslDTljYFtI1mm3L3G+es=;
        b=gMVW1OpNxZGCbfGiZJN7CWogRmhb8O/8NZQJUjl5VvDOFm8axyCM3Qpxe2lI4LTrUd
         S23mQS6EhykZyiPZAZchKhUFyLauUNI/PTXzvvS6fpIB8YFJd0EwSz/LdLHeMo5qf/Je
         6VVfbR2V6g55pg4cEajPSY4yrFuGdGoEoz50ZVvO2khmL7gGXhIELMHTqgr9FxkwFCO0
         tfH2hYNk7YErLOQGsxdnMpYZwupbPa2WqU4r5r8XKk27iFdmNQZs2/Pv20ZzMCFVmkYF
         /415sca28vufjjPWayU2xZn2j/5RKYAHoFit+W5tRiL+xJN6X2GLoRIwsp/lGkN2QDzM
         3KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737478814; x=1738083614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O7kZyVX02YaNVvlK+AnjIGslDTljYFtI1mm3L3G+es=;
        b=lGnTbRWrBRlK7G3M+G46ai6f4FOET4eHZIGsvePltJVuy6ulKHFIHM96u1jR16Ahv+
         MlqF+IelPynlcok9yft6BzyNfcOodv2v0Df8bz4udphrKAb5o33faizDojADtiGmIzc3
         BLEiPen3rNdczIJA3rTBX99YYldatJy+JQP4YmYiA1nv/Kna5FsEdUcqzz17RQy3EoEZ
         UvtQT3apocOGImoKdBhtmHCOlaDfM7XgtEbDlhU2rVuAbWCYmfL1I7tyCsMKBCO+s7ML
         mOOoKBDweKRmaubPYtdYQSXowFBQv+lW6gHtR5QJA8X9M7ICxRHSR9FcUIIMwHBXOU+r
         7pvw==
X-Forwarded-Encrypted: i=1; AJvYcCUigKuYSYVlzKBRoOyZiyvCekM9de8/BgmoF01epWwnOBzPGeufLLCysMPTIqb8vCV2WR38hiqjk3gsNb3nhHcy@vger.kernel.org, AJvYcCVNtzF3fjeLtXQZpDdR8q/KVhJGX5khPOSOMCulvucvUlhK2JGnHQ2OU5hbqfNl3AMrS5OQoEI3GeKwa41qLehO@vger.kernel.org, AJvYcCVX9kf658Bb9flmPpGTJY87XSdeeA/XrJLR/TagmZRByVCGL5YTWs/6NFt68iRpGbHiH8s0vEBdnHiVG0DdXZoMtQ==@vger.kernel.org, AJvYcCVxfB0VZE0r4TTLNqtq9Qg/wCiwgdqMY1S08/n7UCSQQZy9cAJX1oO9pYSmBKgUYqHuYE29cMW9+rlXl/ed@vger.kernel.org, AJvYcCWIFd7d3dJIXZOFjEqSqqXGsZAnLqpxHPvrGFclJTIKJMBLf5++N/JS5lZP12BW0uEMyFQ=@vger.kernel.org, AJvYcCWlOJMi9Xi/D1sWTOXFPlgdWmNj80HvNhhD9dCFNH1lLYwrOKLp5uirslT2Pd0TChwB4yleqmRh31Baxw==@vger.kernel.org, AJvYcCWppZQM2mzUCKA6kpil5RUMmVWvUAPYCfe6r4YwJ61NwYKnAr0oAyjXbz5jAl9FgX3r7MBK@vger.kernel.org, AJvYcCXn5XNKxjuU7Yn3tN4Bp54J7ly3jq96QxClg4eMau4u5ragf3oAS+gD+3a8ZY0aCLQDHZZD@vger.kernel.org
X-Gm-Message-State: AOJu0YzwnMRjNfrhr2ORtkPt2uwTzgrLHLRF2n4bDrukhK72y9A6qGWh
	M6W4ovuC0MOgm/tWbLdgRs6o5r6HN52B6rXnVXcPAK+PUDRAPLQKwCLoU7w3
X-Gm-Gg: ASbGncvtj7NdDPURSgbMGbW7o1rNFvmJ/oyRzvKReHpbORks9jSKs9ZjQDH4Exrk0Nt
	ID/QCnEt8abXtOpldDHMNyRHEvD+89Wkk38DMe0K/EkbDansjdmpYkAAL4DwqDTpZtvrMapT7Bu
	u4TOzZhp5YmnzYiq0p1f3fYpSOHphihAKouMGnfpXxUFqEZUrS5hATbc9Ry+jx9/M2BNube9dO6
	9RQW0VVOnVc/fmKKjRHE/dWY/3oWsZEfTQ8UerOU3xOHwY3LiVCPCkfShdcP3wQN2LInp7oEl7U
	DU8Y9FiOIHbo4bsGSYvCI7h7
X-Google-Smtp-Source: AGHT+IGYPF71D1RmaKnbW82c+U5IMmpDPZJTk/HJCRRaq5z7S90tH0rTVzhA6Sl8Kwc0O/33Vf8jgg==
X-Received: by 2002:a05:6512:104b:b0:543:9b0f:7d39 with SMTP id 2adb3069b0e04-5439c282920mr7151519e87.32.1737478813837;
        Tue, 21 Jan 2025 09:00:13 -0800 (PST)
Received: from pc636 (host-217-213-93-172.mobileonline.telia.com. [217.213.93.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af76fe9sm1916768e87.212.2025.01.21.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 09:00:12 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 21 Jan 2025 18:00:07 +0100
To: Valentin Schneider <vschneid@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	linux-arch@vger.kernel.org, rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rong Xu <xur@google.com>,
	Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jinghao Jia <jinghao7@illinois.edu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer
 flush_tlb_kernel_range() targeting NOHZ_FULL CPUs
Message-ID: <Z4_Sl-zu7GprkbaL@pc636>
References: <20250114175143.81438-1-vschneid@redhat.com>
 <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z4qBMqcMg16p57av@pc636>
 <xhsmhwmetfk9d.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <Z44wSJTXknQVKWb0@pc636>
 <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhr04xfow1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

> >
> > As noted before, we defer flushing for vmalloc. We have a lazy-threshold
> > which can be exposed(if you need it) over sysfs for tuning. So, we can add it.
> >
> 
> In a CPU isolation / NOHZ_FULL context, isolated CPUs will be running a
> single userspace application that will never enter the kernel, unless
> forced to by some interference (e.g. IPI sent from a housekeeping CPU).
> 
> Increasing the lazy threshold would unfortunately only delay the
> interference - housekeeping CPUs are free to run whatever, and so they will
> eventually cause the lazy threshold to be hit and IPI all the CPUs,
> including the isolated/NOHZ_FULL ones.
> 
Do you have any testing results for your workload? I mean how much
potentially we can allocate. Again, maybe it is just enough to back
and once per-hour offload it.

Apart of that how critical IPIing CPUs affect your workloads?

> I was thinking maybe we could subdivide the vmap space into two regions
> with their own thresholds, but a task may allocate/vmap stuff while on a HK
> CPU and be moved to an isolated CPU afterwards, and also I still don't have
> any strong guarantee about what accesses an isolated CPU can do in its
> early entry code :(
> 
I agree this is not worth to play with a vmap space in terms of splitting it.

Sorry for later answer and thank you!

--
Uladzislau Rezki

