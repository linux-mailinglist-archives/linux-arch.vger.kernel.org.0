Return-Path: <linux-arch+bounces-14392-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A8C19A27
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1F24270D0
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43D2F0C6E;
	Wed, 29 Oct 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPQJse7W"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0501E766E
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732992; cv=none; b=lzfhC6GQ3r4vx1+IBQyGVuUpWyCLw9MGcQm2sP8SxmIhC2mkFHGVjBt3c1oVkIH8fVgJORc7WWUmWzqf3YBvz6gtQxzH6JnowfqD5Ox8Qv3F5d0Y0Frf0rtfis0cjbRSEfmh7qRJ+79euTJHNqVRzJg5ZKnanUCzlgpRn6bf7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732992; c=relaxed/simple;
	bh=DmAXt+vGHdY0UKr3IkSZsuk9F/CPqLHM9TyDZczLVNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKfRLkGqxDIHnvaaN0qNX3iGEddSH9oEIRBlrSfOghQQ55e8HAu4khskXIygekDG1zYctS7dvJxb/bY1xe2TCW0383v0aUhazPeH5Ddo+HWUUX4RrTpBM8iviEjPMHzX7VBJSnQ/oFSpVzH/xHrQ2PfwNYGc55LbkR8YYk+6lNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPQJse7W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761732988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/btFKEFxhLEeC8J1xdXSDjZgEcY68zMIb5ZfPzXsUAI=;
	b=UPQJse7WhXypXEdNvvLmWmI6oKvgrEPxn0krDylhVEcfR3u1RhrmO6p3H+ooiQzUrOLUV0
	8AVZUVkNaCQKVP0O0H/3/nMvAO/VqOlTZcWvAO6+UtDuOseM/7c3r5d7a7G7ckDU7FZ3ot
	2dcVbyZI5vowNyLZO5LN7Iyxeiw6E2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-bIT8yRxmMUKD-To068meaQ-1; Wed, 29 Oct 2025 06:16:27 -0400
X-MC-Unique: bIT8yRxmMUKD-To068meaQ-1
X-Mimecast-MFC-AGG-ID: bIT8yRxmMUKD-To068meaQ_1761732986
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477113a50fcso28835125e9.1
        for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 03:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732986; x=1762337786;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/btFKEFxhLEeC8J1xdXSDjZgEcY68zMIb5ZfPzXsUAI=;
        b=p6Zlb1H1cqGpwgAdnh4WxfBRF1/Ei+ycEx22yh4h+SyvtHpALrxsLz1bxtlnp2N8hM
         85x0Gsa6bYNK1d+KAjCJ75YvXlmZyQG188oCHCcPo7BXl628f7VRDX1fpVSM38JIMkp+
         A/xeJMLxQEJHwoQbo34LYJBL5PKWC1SQzrkZxMvaewokZKsVAl34bkcNe50TIDJNUl58
         I9tZy8epIkPEaBPCGBSMHUB/9BZGDTViwWGiKXkAraYNiDN1Ed3R+kYUQF3o7s4erdDX
         nVeRUOQ1pZyf04WfQCPto0ytlTaYi4dsW6/lgx9Py7cZ5s5zQmBKGz/ucj8mRwVIggD5
         ptfg==
X-Forwarded-Encrypted: i=1; AJvYcCX2D/6p+BMYzOYY7ZIqp6zYXXsaFvsihV8a/8Mulf4dpqdsakQCrSF2VD7poe5HQIJu9MHyb4HAKcj4@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkTGP2O8p46RaTjPeJd5ALLH2Kb+teXwxlCvpvNoDAzy79QrY
	KKVBN7FGWJ1WzNKKJebx8A3m3v4wbfl1ChYzPjSyqw9lc6nmHIoJE9ZCDsAiBTkJ/xTdqYn0PMJ
	zGo4px3YB9UGezLSk8nIiFY+VXqwmHQ+o3OHN1wJWugXmAusPOSG82B1nkst2PTQ=
X-Gm-Gg: ASbGnctZt7GZUMHFJ4Qa5hSgXKBI8APA1mUMC/gftQnz/o0Nw8EskEQqOzhTeCYyaRX
	/Jcp6sTx8gf5a92wXSeurxlo+K1PgtuGrCU4nha2X9RlC2pMkknkzoEjqT93tlAY21QjSvPBrbZ
	VfB97nVG5Rx9FgA/8SCzCrmFVNsuz3PUAyWylU+LkmPiRvBVUWAMB0kuHttzzk9/QueMO44W/iJ
	4bBpSSA5wi8MAYSoFI7I2BbJQJjeIc+6lLoRWFPtbtRyzG4ifHWnp+aF6e2Q+w6loGdWxhKy7ln
	i75xUuCGtN/OqG5N/SQjcoeK+nFDd5HNYEBlY+z8Qnsu7Cp4tZWncX5zFYMkUDvw2WxyzKaNyr1
	+9nNOkLaSRfNzfYn0ZqVVWSBXNiXQ7Ito4ezY5nduSnvw15yClExbD1fiQgYD
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr13218625e9.23.1761732986079;
        Wed, 29 Oct 2025 03:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENaoAuowDmNKRs2e7mInj3dgyeHZe08An/EQmhaeEKImjMyXA9vgcPYVOhC1MZ8t+wInccTA==
X-Received: by 2002:a05:600d:4398:b0:475:dae5:d972 with SMTP id 5b1f17b1804b1-4771e85156emr13218175e9.23.1761732985564;
        Wed, 29 Oct 2025 03:16:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm25828786f8f.6.2025.10.29.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:16:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQDoVAs5UZwQo-ds@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:16:23 +0100
Message-ID: <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 16:59, Frederic Weisbecker wrote:
> Le Fri, Oct 10, 2025 at 05:38:37PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> @@ -171,8 +172,27 @@ For 32-bit we have the following conventions - kern=
el is built with
>>      andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
>>  .endm
>>
>> -.macro COALESCE_TLBI
>> +.macro COALESCE_TLBI scratch_reg:req
>>  #ifdef CONFIG_COALESCE_TLBI
>> +	/* No point in doing this for housekeeping CPUs */
>> +	movslq  PER_CPU_VAR(cpu_number), \scratch_reg
>> +	bt	\scratch_reg, tick_nohz_full_mask(%rip)
>> +	jnc	.Lend_tlbi_\@
>
> I assume it's not possible to have a static call/branch to
> take care of all this ?
>

I think technically yes, but that would have to be a per-cpu patchable
location, which would mean something like each CPU having its own copy of
that text page... Unless there's some existing way to statically optimize

  if (cpumask_test_cpu(smp_processor_id(), mask))

where @mask is a boot-time constant (i.e. the nohz_full mask).

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs


