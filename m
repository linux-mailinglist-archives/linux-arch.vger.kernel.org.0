Return-Path: <linux-arch+bounces-14521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB206C36ABB
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A009134ED3B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163230EF7C;
	Wed,  5 Nov 2025 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmopsFdP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKq1zyDD"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE4686334
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359879; cv=none; b=qCelsapfRGfjkhma1Ou8nTwiZk7DVMwe19Sqa5z9EuFBUsdE2rHWaqJTzSxorAkcJT6c/PjU9k28u10XELjVi6zKFq4uJiWvfVldOHIDR55Vm8B0JSHhKoU4qDHQymiRudD08U+OyY5JqEgKFhVqyTCwtSo42W/jQCWLaqKn4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359879; c=relaxed/simple;
	bh=Fflidx7xTzSLnI3Prwh+YYynUZ15M7y2pcYRBHfDZ5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KQDmMWLm9NVcgKXPHMFn2tFBWagt84sJHKfNE95NDikV1FOTiWxHu384kjWPdguBaCjR2y7R1JpBrLvOW3zHk56029SDDlGLhyRMUSuAVIOx57lrYbLQ4ANEoCenY7kspCECK8Y0dQ0fzU3ERPuNpCogWA/GRlEJ27FvfAJGs6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmopsFdP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKq1zyDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762359876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
	b=DmopsFdP1EdJvoClL2S9EALuNLiB8sEYj6RifbSP342V8EqpKpo92ULT+JyUdn7Iw5/veS
	bGzK1sb03J0NXHZb6wyERWVbWOPgPRCVsC63KkaOejukzp+hQUQNcmw2QFHgBwU1pw3aUX
	bVc1JwRV53e/4rMfD5FTM7nbqzdG3PM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-yurvBqx0NxCtlkiVDDm25w-1; Wed, 05 Nov 2025 11:24:34 -0500
X-MC-Unique: yurvBqx0NxCtlkiVDDm25w-1
X-Mimecast-MFC-AGG-ID: yurvBqx0NxCtlkiVDDm25w_1762359873
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c8d07874so5587f8f.3
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762359873; x=1762964673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
        b=PKq1zyDDMhJz7TMdiLUGglU4RMfHBVbkqi6/8Gah/5D1lbA96wM/quVmfjDNhtPEGW
         QlAFYeYHPzY2g7qgUkta3iTK+znskcZL9S5Ih9Sz2D/ogoU9rC8/O6uDEzbbUNzkqzvA
         9D+Vj/Gc0IkvfEXKz2CMawAzkGR22bpqb1S0B/G3+Sp9VFmk73dElJOFjDyGSWERagWc
         zU6YamwJXDnRvN6sI/FSRPN260fQUPYZuNIeXaV/iHuWNVhjf528TnDyXdJ48+/vAAHA
         zlT17Xl4V0N9tF0ujowitHIYj9GKzGloATTxMP0xd3OGkJwHs6STVgiwv8Ai0TdRl8TO
         ssdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359873; x=1762964673;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPk6YcBuruLXQ/o+Uci3gsoXIOQlnGdWukNwLQbwsoc=;
        b=XtfL+Ena2j6Bm/s/L+3wFbuztMaAKSNJh7PKeanmj5A6UcLVBr8zDK49TMBJU2HeBF
         UQviVC2tQRO/MXgKfm+fE/YGJVdZktojNvZfin9Lgq20S+0Bf1+RPbxUjA98ue/VZn9w
         1GeOp/O6ZxDd4+V8TRumw3Mmx+Q/oxelnfJzwi67r/SGI28KrTdP8Ry3BFSxkA2MAf4k
         uPWhCGq+lUcQktjMDYLtfCyKMPghKa1x6fu7R2oRU3n+fCnWHnXylo4lr79HOoPcYkac
         X+LoHwLZCIdt7lAqJ2XXDJBCJ+P+zXZkT8yYMnDkUo9urfEYt0PeghQOC5Xrsht8AU3S
         3hzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN6W59dZhAdA/7H37GVSAgldLEg3kmH+MnPu3Ho+vg/UgwU1kV6dhwsEq6hE6p0iiBoL9/f3gaCNl3@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1KGz6mJSkyE90GaAQMGeefLJjuFMesxOCB9Gq+72HHvzvBya
	XlZlO7HaCDaPiOrH9/N/UF70yX1Gyy2e1eefJrdcCyyDSjCLcN2g/MEbkvaj+6HqhEKkmgwSzBg
	rFxH6E1mCmpjdiuRQoE9+Y4NA/YBHXor4/2y5Gj15hLQZ9FphNtJ/lZLghQTKZyc=
X-Gm-Gg: ASbGncvh8VsmPQA8FTWq/CbE9S2Wm+tnTac+mT+AaWIw60dlIeTU/lpYJx0UmWyBaFb
	IffH9Q5U1i9h4Y/2fQZ+qpd56R90x/qZh8d7QNjgzLheXbecS2YiROPzFa/r55QqF4LFc7QNERl
	KVWiEDDiTL9jtWKZxF6Kta18lM8LBKgS+tfmlkdA/sJjrP31Y27ToYlH4tqW2D+QxdRmFgOZERm
	YMdvKPE9MGXyZ3kRci+Ve8KHCPz6PsHLoH17hc8w1/1TvuHHUdUHTwQ389H0ehUPlWTD6yoQR0l
	q6WGzM6vPNrmZv06hy/fqMobGblGQ4eGbK3BYbuN52+LakQ1AkAYP21Fov0XfkYu1qAKzoInSWx
	7FIpQw1lVVzQgeAxTguTtMSw0Yn18F02t6xkyAAFiN7UtODwSgrU+LEQrD2Lo
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563196f8f.58.1762359873174;
        Wed, 05 Nov 2025 08:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL75fsQ0H2l1YahgWByyszuFW6670iMBa0il80FwPsU0pgmLcV2khMdpXTiSamLH801kgv9g==
X-Received: by 2002:a05:6000:2907:b0:429:d4c2:cadb with SMTP id ffacd0b85a97d-429e3311ac6mr3563132f8f.58.1762359872637;
        Wed, 05 Nov 2025 08:24:32 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fd2a7sm11003113f8f.39.2025.11.05.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:24:31 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQJLpSYz3jdazzdb@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
 <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQJLpSYz3jdazzdb@localhost.localdomain>
Date: Wed, 05 Nov 2025 17:24:29 +0100
Message-ID: <xhsmh8qgk5txe.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 18:15, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 11:32:58AM +0100, Valentin Schneider a =C3=A9crit=
 :
>> I need to have a think about that one; one pain point I see is the conte=
xt
>> tracking work has to be NMI safe since e.g. an NMI can take us out of
>> userspace. Another is that NOHZ-full CPUs need to be special cased in the
>> stop machine queueing / completion.
>>
>> /me goes fetch a new notebook
>
> Something like the below (untested) ?
>

Some minor nits below but otherwise that looks promising.

One problem I'm having however is reasoning about the danger zone; what
forbidden actions could a NO_HZ_FULL CPU take when entering the kernel
while take_cpu_down() is happening?

I'm actually not familiar with why we actually use stop_machine() for CPU
hotplug; I see things like CPUHP_AP_SMPCFD_DYING::smpcfd_dying_cpu() or
CPUHP_AP_TICK_DYING::tick_cpu_dying() expect other CPUs to be patiently
spinning in multi_cpu_stop(), and I *think* nothing in the entry code up to
context_tracking entry would disrupt that, but it's not a small thing to
reason about.

AFAICT we need to reason about every .teardown callback from
CPUHP_TEARDOWN_CPU to CPUHP_AP_OFFLINE and their explicit & implicit
dependencies on other CPUs being STOP'd.

> @@ -176,6 +177,68 @@ struct multi_stop_data {
>       atomic_t		thread_ack;
>  };
>
> +static DEFINE_PER_CPU(int, stop_machine_poll);
> +
> +void stop_machine_poll_wait(void)

That needs to be noinstr, and AFAICT there's no problem with doing just tha=
t.

> +{
> +	int *poll =3D this_cpu_ptr(&stop_machine_poll);
> +
> +	while (*poll)
> +		cpu_relax();
> +	/* Enforce the work in stop machine to be visible */
> +	smp_mb();
> +}
> +
> +static void stop_machine_poll_start(struct multi_stop_data *msdata)
> +{
> +	int cpu;
> +
> +	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))

I think that wants a negation

> +		return;
> +
> +	/* Random target can't be known in advance */
> +	if (!msdata->active_cpus)
> +		return;


