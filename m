Return-Path: <linux-arch+bounces-14394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B2C19CCD
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 11:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C067F357B54
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 10:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1488633CE8F;
	Wed, 29 Oct 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeTKGnXh"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAB3074B4
	for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733988; cv=none; b=mB6FL54AiWj7SPTO+SDLus0USCUz8SqCFRQrkpxCfCN7LfpB7A0dC0nDbW2muONmhQWXQe/PodKm0XZx/XcUvHZo9WJUpXX4CTiULN+zhkEqQRivhjE22Lr926xSyadN+93hWvdcuHpt8kfrKulsYW8Ux5iozAPIHb0bEJBG3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733988; c=relaxed/simple;
	bh=hJtwdK757CQ9l88ORyal3ZjM4fe6wz7nP/MxATLRzCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=plFu9l1fkkV158b1YxAl/7NDsAsfBb+LVtOvOCfFw8zWKeUoxN2jxeFp+0Tz2/osRRsoRLvpivhRoukBiHvsMl+PovBF5ED8LOrl6WzuGY1Dv7sD79tdwMEnU8ZmwuzcQBCiCsJKfWg+k69gHbRn7Y4EunDkky99CWRQ+udVERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeTKGnXh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJM20FESPr5Q3wolT/mFDxUYnwba82V6xz3P+wmiM7o=;
	b=VeTKGnXhl0mrIh2wROZa1f73MpFDHjHQxVBNwzAAuIpMllicAVPPTKvJ4otwnYPxysLwN3
	F0Phg3WQMYip9uiEdx/tos+PmmVH/2G3QuAfHkX68kt3IkXBygDLQHj9r6iW0YEEI63C0b
	7Q6JDxPvGNIcOKARGtcwA25R+1JPj2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-w50bgny0Nfywnv_8RapDkA-1; Wed, 29 Oct 2025 06:33:05 -0400
X-MC-Unique: w50bgny0Nfywnv_8RapDkA-1
X-Mimecast-MFC-AGG-ID: w50bgny0Nfywnv_8RapDkA_1761733984
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso53690045e9.3
        for <linux-arch@vger.kernel.org>; Wed, 29 Oct 2025 03:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733984; x=1762338784;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJM20FESPr5Q3wolT/mFDxUYnwba82V6xz3P+wmiM7o=;
        b=AkYpMdrQsI9MwVKiL9R3oxuho75ldP/4TjZ/RJI5IiaLoBcAQH9gnsowIUE8wm58w5
         G9LCxtTCJ0LjYzrDk3fJ5QnOcjVUoazx8YOF+LBOfzNFycbKkO99d7Bneyi65XhPX9YC
         cYddQ2RfyjdUJJ1Yg7SV3Zk83l8fGNL/1ouurPAaW8Sd6rrlgsrbtpH+ayEKqamlUaKS
         bN+j0XNiKIvbaOq3gUv4zIv3AoJtsHWaIfA+rxaT/yiebtXvAZf7w1hXeIEBcx5DtaLb
         /VsJJvVmJePCqD9TEA3pYuaKtggf4TSNzdwmyME+uib0Dk63CGBlrMVAcJTUEizHTrIQ
         2cUg==
X-Forwarded-Encrypted: i=1; AJvYcCWpCAn9W3IbZhFnH5nKK0tZ8DynPt/58JyNmnR4FMTK2P5zZgt1A83Ckfr5Acvu9weKJ4XTZ5VTCaBW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9M8ZclOzaBxLuR6HMixEI7VS2pwj0PJf8A7lDYbFVQ7mSobjH
	OWbHguzoexrgIbxrMIxXyVjCPXo1dgjIsDjfZ6WdkktYOsVxy7u3Voo2exmLS5r0+5wsfSLHNTa
	HPhpkBeGfESUgoRQd5FMjinp7DwAbx5hWHqotnMfdxKZVj8JT2ROAaMW3QpVs6Ps=
X-Gm-Gg: ASbGncuU0H3OG4eHZiE0kZhSc0PFTxMbdDyTWrZH/szJxgqtONJVuhNg1h49wof+4Er
	p3qaDS4B1GMezc37DgEStiDg8Mw6EVS4tNpj3XNm9tod5DE+tEEYwvww9T4e7VAk3oh0EXsaRSQ
	NECm/GbVP9DtkIHDRpeMTb+phn80BnLSliIGLXyXVBHcWLoTd+wqydaL83AuJDBXc5kXjO6cxua
	kpLu3SdfE55z9Wg+1p3tQ50g8LGMX9V7hXFcxXLOq1rh92IvgvK/8az0DvdisgzSqAUGU53xLue
	a/AEx8P1gy+lH+7oPzyE/IMfVHqvfMlD5dM/mjhO1otm2B02F0umExRHxLacVtXOk8cwYegAb1S
	3lZuYiVJVp2bco0l0o3MBrOB16Nh9yhtMJi/y4dXyB8ec6nhLnkCElMJOHR2G
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21410865e9.22.1761733983692;
        Wed, 29 Oct 2025 03:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxlh/PGW1+wNXuO1RQYN4fEeAqw5AdQXtt4ynjbr63hSK8Qg5GeiiDecSDqHTa53KxpVgVKg==
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21408835e9.22.1761733981314;
        Wed, 29 Oct 2025 03:33:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm25638297f8f.4.2025.10.29.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:33:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>
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
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQDuY3rgOK-L8D04@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:32:58 +0100
Message-ID: <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 17:25, Frederic Weisbecker wrote:
> +Cc Phil Auld
>
> Le Fri, Oct 10, 2025 at 05:38:10PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> Patches
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> o Patches 1-2 are standalone objtool cleanups.
>
> Would be nice to get these merged.
>
>> o Patches 3-4 add an RCU testing feature.
>
> I'm taking this one.
>

Thanks!

>>
>> o Patches 5-6 add infrastructure for annotating static keys and static c=
alls
>>   that may be used in noinstr code (courtesy of Josh).
>> o Patches 7-20 use said annotations on relevant keys / calls.
>> o Patch 21 enforces proper usage of said annotations (courtesy of Josh).
>>
>> o Patch 22 deals with detecting NOINSTR text in modules
>
> Not sure how to route those. If we wait for each individual subsystem,
> this may take a while.
>

At least the __ro_after_init ones could go as their own thing since they're
standalone, but yeah they're the ones touching all sorts of subsystems :/

>> o Patches 23-24 deal with kernel text sync IPIs
>
> I would be fine taking those (the concerns I had are just details)
> but they depend on all the annotations. Alternatively I can take the whole
> thing but then we'll need some acks.
>
>> o Patches 25-29 deal with kernel range TLB flush IPIs
>
> I'll leave these more time for now ;o)
> And if they ever go somewhere, it should be through x86 tree.
>
> Also, here is another candidate usecase for this deferral thing.
> I remember Phil Auld complaining that stop_machine() on CPU offlining was
> a big problem for nohz_full. Especially while we are working on
> a cpuset interface to toggle nohz_full but this will require the CPUs
> to be offline.
>

Yeah that does ring a bell...

> So my point is that when a CPU goes offline, stop_machine() puts all
> CPUs into a loop with IRQs disabled. CPUs in userspace could possibly
> escape that since they don't touch the kernel anyway. But as soon as
> they enter the kernel, they should either acquire the final state of
> stop_machine if completed or join the global loop if in the middle.
>

I need to have a think about that one; one pain point I see is the context
tracking work has to be NMI safe since e.g. an NMI can take us out of
userspace. Another is that NOHZ-full CPUs need to be special cased in the
stop machine queueing / completion.

/me goes fetch a new notebook

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs


