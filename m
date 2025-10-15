Return-Path: <linux-arch+bounces-14120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D0BDEB72
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81F924F508E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF921DC994;
	Wed, 15 Oct 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCuN46ob"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F601B4244
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534185; cv=none; b=BBd+jNmxr9rdrorHhq+46ZoK8JpHlFtG+k/wJgcmGFKQ6UFTJCu6C+TqfLXPmzsz/V9I99TS4UqwsJftcs1pTjbtjuvqu4P0Bg0dMwlLoCi/0+trOe/Sg8IkMtO9HpfYQP3JGRB2HlrCLNjJT+h1fV+nL5PKh4VUdCQX7nJWaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534185; c=relaxed/simple;
	bh=M7sveWIwSyElJMftUtieF2H/cZGlYIv8nec0oGZVR9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iKm7B43nt1/wTVtcXcevapbIssXWdhX/WAulEbeXnKMtWrjEC9y1s/0rIWmk6hCxtM4dj5BaTEbPFU9FEUK9z2uH8fbDnK6hbdOEt0vJ/AW5zhIQNmcPbgf//lDX/NtZkjJJAjQ7o8dsAUbidMEK/RGiTL/oyrcg97C8OJe9YLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCuN46ob; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760534182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yD6dvIl7J8wWJkas/YONpCBWDBu3WvjIWx4zsxh951U=;
	b=WCuN46obkcXO1LZdnnfLQ1G8dMenUUbvJpyaZXvoXSxMUlQ62kBQszMdsfmKMc9JMhm1AA
	yVEgRBEgMpJtjwFwGZQMhOGQTSJBvy9mQPe39QsJv7Y7PyVPQ+S5XUqRVT3rMPUcReYYVT
	qGtrprHbt3DPSDAnU7VaBB2p0KQdCGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-5s-fA41qN1Ouz2ZyG9Z8Qw-1; Wed, 15 Oct 2025 09:16:18 -0400
X-MC-Unique: 5s-fA41qN1Ouz2ZyG9Z8Qw-1
X-Mimecast-MFC-AGG-ID: 5s-fA41qN1Ouz2ZyG9Z8Qw_1760534177
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42421b15185so4547113f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 06:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534177; x=1761138977;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yD6dvIl7J8wWJkas/YONpCBWDBu3WvjIWx4zsxh951U=;
        b=HfM515TJ8cQ9dpi6GCwP0HDoqq+6rFS8HSqzipI2w/Md8zn2yrMjSkWLECzTbjW3+N
         VdcKAXRoqLYeX2B2XCu1m21EcSCmhT9oBfwRyMqZfKU90nF1ZLycdjvnAs1kn/H42lHM
         K7Qb9LE/Gh5Ost/3NJSMgryrOmfpo3OOhcjq8ZKoSd4y/6OYvLd0dz25GH2tV4e2j+7e
         Izru2CQeDHdRI5mbb36lxSJ1Zsja9o1wanGvRzeBB5Rjbw2SUu/Rh3jMtn3ch+NNdYOJ
         knBiXz6pLz8s1mbm9pHveidV6eJlFnG/7O2z3hLFJeAlck8oVXBx7K5RypAYDz6KXYUI
         1dtw==
X-Forwarded-Encrypted: i=1; AJvYcCU1FpP0prbjjnBuL+dV+FQ5FMRhIX1NJQUyEmfmoMPEBIeL6m8AcChw7haUnxLXcnXzWT8FYG7wa3TF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oEhn6btRfyiDz2jGhgzXWh+J9+9+VVbrnzjyXGTlVIO1H6X6
	JBDOOtce0HDou+SqXdF1TRnCPXgvGob9hjTztohRL9JOk87jKZ62z2BrD+jd0F1k9oXe0Kme46W
	LP0N/3Rha8xG05DLsPv7N6vWrRFee1/qPEK5iiuO1B2DPRvLDm15NifcZntJt0fY=
X-Gm-Gg: ASbGnct9eitj06hkv9IvodASVqrLCa+vPNExJdIVB5nYeuKzpJcLS3kQneWl2x2IGRR
	Em0EAfE7jxKajI2+Xvu6G56aZ63Z7PannXdKH4+yIKvqnYG6e5WEftoa6c3RUc11c4pXq4TasUf
	4NQnyM6tUlGExyOFJfKOgvR9hvxM4/hO0sr79m4DGEho4rrVufiemajCFboNBJNFWzoC64EBDyf
	TWVpJVSlTiqUM9RMV1LUlOme2Ojd8/0wJi5j9ypdVxUCCXtTiHpDaS71a6ZpmZZnQ1fDuSprT6l
	wR5v/dQOq92RCY0UCdLpdGgqDLfucMD6sGu7LBxWNCSCwm5CZfGtQ0g2+d3HF3598DVz106LPkK
	1rNrztuKa9MWSnDwdJY+u/h3yJQ==
X-Received: by 2002:a05:6000:248a:b0:3f2:dc6e:6a89 with SMTP id ffacd0b85a97d-4266e8e4c29mr18416333f8f.57.1760534177118;
        Wed, 15 Oct 2025 06:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcUjf8Yi428dP9FWOn2X364zzJqp12CDvIxSjruyz4UDGZF5I3K12BFelQ7PlgEZWXYUZIhg==
X-Received: by 2002:a05:6000:248a:b0:3f2:dc6e:6a89 with SMTP id ffacd0b85a97d-4266e8e4c29mr18416272f8f.57.1760534176503;
        Wed, 15 Oct 2025 06:16:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57ccb1sm28976327f8f.8.2025.10.15.06.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:16:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg
 Nesterov <oleg@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aO5I2WGtXqSPYFmH@jlelli-thinkpadt14gen4.remote.csb>
 <xhsmhzf9tld2r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Wed, 15 Oct 2025 15:16:13 +0200
Message-ID: <xhsmhwm4wl2zm.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/10/25 17:26, Valentin Schneider wrote:
> On 14/10/25 14:58, Juri Lelli wrote:
>>> Noise
>>> +++++
>>>
>>> Xeon E5-2699 system with SMToff, NOHZ_FULL, isolated CPUs.
>>> RHEL10 userspace.
>>>
>>> Workload is using rteval (kernel compilation + hackbench) on housekeepi=
ng CPUs
>>> and a dummy stay-in-userspace loop on the isolated CPUs. The main invoc=
ation is:
>>>
>>> $ trace-cmd record -e "ipi_send_cpumask" -f "cpumask & CPUS{$ISOL_CPUS}=
" \
>>>                 -e "ipi_send_cpu"     -f "cpu & CPUS{$ISOL_CPUS}" \
>>>                 rteval --onlyload --loads-cpulist=3D$HK_CPUS \
>>>                 --hackbench-runlowmem=3DTrue --duration=3D$DURATION
>>>
>>> This only records IPIs sent to isolated CPUs, so any event there is int=
erference
>>> (with a bit of fuzz at the start/end of the workload when spawning the
>>> processes). All tests were done with a duration of 6 hours.
>>>
>>> v6.17
>>> o ~5400 IPIs received, so about ~200 interfering IPI per isolated CPU
>>> o About one interfering IPI just shy of every 2 minutes
>>>
>>> v6.17 + patches
>>> o Zilch!
>>
>> Nice. :)
>>
>> About performance, can we assume housekeeping CPUs are not affected by
>> the change (they don't seem to use the trick anyway) or do we want/need
>> to collect some numbers on them as well just in case (maybe more
>> throughput oriented)?
>>
>
> So for the text_poke IPI yes, because this is all done through
> context_tracking which doesn't imply housekeeping CPUs.
>
> For the TLB flush faff the HK CPUs get two extra writes per kernel entry
> cycle (one at entry and one at exit, for that stupid signal) which I expe=
ct
> to be noticeable but small-ish. I can definitely go and measure that.
>

On that same Xeon E5-2699 system with the same tuning, the average time
taken for 300M gettid syscalls on housekeeping CPUs is
  v6.17:          698.64ns =C2=B1 2.35ns
  v6.17 + series: 702.60ns =C2=B1 3.43ns

So noticeable (~.6% worse) but not horrible?

>> Thanks,
>> Juri


