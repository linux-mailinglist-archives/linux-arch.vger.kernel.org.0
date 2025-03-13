Return-Path: <linux-arch+bounces-10703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C282A5ED18
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47F63A6665
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556225F995;
	Thu, 13 Mar 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRjHhLxI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE413BC3F;
	Thu, 13 Mar 2025 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851310; cv=none; b=LyaGzSaFaHVj2eW3rMak5nL0zkR/dLRJN24JZudoZx9DUx7kbbVMMOxS16Zf4wNnKPTp8xyys19dXTPGFIAY0gh6G06X7VEI1VwECtCNE4PC9ZGz5s5cRbiQR57XFPN9IoAbMNlKuaVLwXhihdjnxgRYqSWXz42QkAVwjhAS3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851310; c=relaxed/simple;
	bh=EdxGxN+VRDwhAkSIvCST7YEsLLAsc4WQBymWR5igh5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+Bzq0heDFLEQl94852tNB76BLnXjSDAbcM6duFNqL+MOWFPijhG7lUkEgGTM1JmVxNO6k1ktNC2325KEhCbtJnl5OTOGJQ4MQvADzxc5tDbJac6qcrEE1I4v36O1r6KzqJo16SYdKxw6NgwuWk5tCItihWP+prC4S6FOzDqjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRjHhLxI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1283047a12.1;
        Thu, 13 Mar 2025 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741851307; x=1742456107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUsrUN0Sa3eMBis7ScutQ4swK59H4nn7rnZNJQLZ63Y=;
        b=aRjHhLxIyJf/6HTj4bJrNEPoxP+KrM9Vtd90FIA8N1OINusUEJRklZuMueLAJnBj2j
         /v06sI7x0T4jt8RIs9EALuWpIPfspg85Ev1racAvLlW7r5YwsHJS65nrsckpdX5mRJk8
         PK6/OII/01fp0O94ci2Iq5gAjIU0aQMsB1noXn7V6KKUNigob5c+/LSbHrn6Kw5g2+cs
         41fu5H7pu400cYcHqpsC1081HghYBn2OvxLErES5UN0QAZ3epiiJ3D3SrSRctFvlL3eN
         43ioQjnkZPD3S/I3gIKvhWAh3pZiNGCD7AVzoyY8hF0wbdI+qjPHYW1R3HytZmFuXRIR
         1Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741851307; x=1742456107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUsrUN0Sa3eMBis7ScutQ4swK59H4nn7rnZNJQLZ63Y=;
        b=tUgkei0m8aTf7cikGISMv3R9Z/SkNdB8am+ZAwd4/6fp4qRQCoosEwPMj49pLK3Lw8
         u2UBA4HRS6moFVzeU4KiUaONOB/5hhA+noXZOvTHZhTbbI+6qsVYKojBePQ6KzvYuTqY
         k96BjSeotHkqyERul4tRrOstQlCwU9GQWoc3OXToS22C5GXqb5wOrClhgRrWzLYNHTF1
         OwUAsP4FLPyx73Iva7FtOhfiZ7MuyTkrhfShH/oH6lnYPtHXxew9n3Bk7oP8AuqaN32z
         mKmvZynZHEnNdCSuI9JX3HDkHedIsOXgp4waxSRWKl89gRa9p3s1Os8hCRztJI4pcQn7
         G9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFlU6/P726+E3MXCbIsB0xiT2H7LGhVoIKcLgI3zEfPJs+kIkQpe3fLkDPnowLgcj/NjY1BuWug4QQiQ==@vger.kernel.org, AJvYcCV/+3uEQ2/pIHGnDdi+od93T50CKMM3E792Lg5HjxLjLoAynmd9m8X5EM9EoJ4n6xzm50YObqJQDbftS6lX@vger.kernel.org, AJvYcCVHgbvJHnnFWzfIdSyYHIIqlDktsqeIL7gENTZwc9gjcK9SGn183Tg5Um6wyouba+YT6WMB2jxGGX0y@vger.kernel.org
X-Gm-Message-State: AOJu0YzK31OG/tpUD/M+i80W22/C0lsEKzXO3jbxraaQvOAFI2YVUu6q
	tnowNeONr3djZkzmgpHyjPE6JoGs9S8OaGJE4aXf4mSY+n1on3RNc3wzEJ95gGARMui4egY0tmG
	74zy/9JObzfHzvfdklA7TvyBEeP/joZ5exVsCwQ==
X-Gm-Gg: ASbGncsN+wpYnzlHvkBbvEkGIFCQ0DFGsYgSVwnc1+mYkmbPOsQKcCyFNrQ5k/6hyJm
	tN+M+h7Ww1ULmlGhLe+aMNG2h+JwahfcznlL2vuzN/IBtp0wUJLrMhkZAHzrfvwRa80deY9hh4e
	Ij76pd2iQqGTJsYUar6iMuuvI66mMGSs8Zr0qUOshPDER6
X-Google-Smtp-Source: AGHT+IG0AbFafmJCSVXuCn9+d9aJ6rWGv0lewSciVuUOX99LLiYxCavfe+aGJvWGZ3Z6k5yceyGSjWwk/zr0TjlaX0g=
X-Received: by 2002:a05:6402:2550:b0:5e5:9c04:777 with SMTP id
 4fb4d7f45d1cf-5e814d805b7mr1311903a12.6.1741851306525; Thu, 13 Mar 2025
 00:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <CAMvTesAW-9Mo0oY6UUh2anp6DQCSsVCUhBiV2-bKp2VD_N0DYw@mail.gmail.com> <5e3e8c30-912c-4fe3-bfac-1ae21242473b@linux.microsoft.com>
In-Reply-To: <5e3e8c30-912c-4fe3-bfac-1ae21242473b@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 13 Mar 2025 15:34:28 +0800
X-Gm-Features: AQ5f1JpFmeyU-ZXvz0ptwRLZ-nTkXcfB_mlOTr3vDPCyoNGFdLAtzHdNo9-Hw44
Message-ID: <CAMvTesAPeLBfYVa5TGx-o6p+0g_Q1bn6s+nZK5i7NK8QGyfbTA@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:45=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> On 3/10/2025 6:01 AM, Tianyu Lan wrote:
> > On Thu, Feb 27, 2025 at 7:09=E2=80=AFAM Nuno Das Neves
> > <nunodasneves@linux.microsoft.com> wrote:
> >>
> >> Add a pointer hv_synic_eventring_tail to track the tail pointer for th=
e
> >> SynIC event ring buffer for each SINT.
> >>
> >> This will be used by the mshv driver, but must be tracked independentl=
y
> >> since the driver module could be removed and re-inserted.
> >>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> >
> > It's better to expose a function to check the tail instead of exposing
> > hv_synic_eventring_tail directly.
> >
> What is the advantage of using a function for this? We need to both set
> and get the tail.

We may add lock or check to avoid race conditions and this depends on the
user case. This is why I want to see how mshv driver uses it.

>
> > BTW, how does mshv driver use hv_synic_eventring_tail? Which patch
> > uses it in this series?
> >
> This variable stores indices into the synic eventring page (one for each
> SINT, and per-cpu). Each SINT has a ringbuffer of u32 messages. The tail
> index points to the latest one.
>
> This is only used for doorbell messages today. The message in this case i=
s
> a port number which is used to lookup and invoke a callback, which signal=
s
> ioeventfd(s), to notify the VMM of a guest MMIO write.
>
> It is used in patch 10.

I found "extern u8 __percpu **hv_synic_eventring_tail;" in the
drivers/hv/mshv_root.h of patch 10.
I seem to miss the code to use it.

+int hv_call_unmap_stat_page(enum hv_stats_object_type type,
+                           const union hv_stats_object_identity *identity)=
;
+int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
+                                  u64 page_struct_count, u32 host_access,
+                                  u32 flags, u8 acquire);
+
+extern struct mshv_root mshv_root;
+extern enum hv_scheduler_type hv_scheduler_type;
+extern u8 __percpu **hv_synic_eventring_tail;
+
+#endif /* _MSHV_ROOT_H_ */

--=20
Thanks
Tianyu Lan

