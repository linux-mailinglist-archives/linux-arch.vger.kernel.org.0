Return-Path: <linux-arch+bounces-2096-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B384B168
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F46285F52
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811D12D15E;
	Tue,  6 Feb 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFZAAUlP"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749D2C6A6
	for <linux-arch@vger.kernel.org>; Tue,  6 Feb 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212212; cv=none; b=LIfyh9so3Go287eeIs79sXlS+d4725F6od0BQoZFduvkQqeYvMz8nzBQthjvwUPBZpzbsPG2JgFuL1IO99N7zEA0wh+ee7103/VgAEbMMZdKyKJ19TUwiUDoXji01JAuwrZY7JYfNWE4eNVgwNludg2IvVpdaEIh9pvMNoid6OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212212; c=relaxed/simple;
	bh=on79fhII02mEwej/WPS02bX/q4h1znp3R1RIv7m+C8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh3ij9sa14QjHXXeZZEuVHoWyfVFz459yK9tt29WYXOYlwGkBXPa0Nr/A3MMpI0KkVzCHxWifLSJi2eJZlwmo0gJyar4Cy4Vlja/qcAodWFAvyBqU8loueJaEjt20PG5GMgy7T1/SHHxBrF9ecirRWGftSgVlCEkSmpFe0aZuF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFZAAUlP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707212209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=on79fhII02mEwej/WPS02bX/q4h1znp3R1RIv7m+C8M=;
	b=OFZAAUlPN2RxtqjHbVFRIKAoLUW+9yo5X4Ip6/29VDzPJyAJrl7TP3EDk2JmZVk3xb6sVa
	7VbZg4QAsKjSsEbt7GiSZ+spyQ0dug7eiwZ4WAldVxfauQm24o298T3icF/fDH09ckLs/d
	Og/WkujNjTzPd7ZxVjL67pnBklGGbLE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-nD8zfu_-M_K5mrPxDcDZdw-1; Tue, 06 Feb 2024 04:36:47 -0500
X-MC-Unique: nD8zfu_-M_K5mrPxDcDZdw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78130939196so245262085a.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Feb 2024 01:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212207; x=1707817007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=on79fhII02mEwej/WPS02bX/q4h1znp3R1RIv7m+C8M=;
        b=ZYQgJhIY8AuuMzmB3PZtmDNZ0fjrBZ3cPp/EBHkB8Lr2IW46vMGC01G4DfLMGQiQY3
         OIfQq/blnAgfau6e8zXG6pcWh6uyMHl2TqDGUSD2BtUujg/4wAx/gky9SqxTmtB9WfnJ
         aM8AraNURb3nQaD8kagheaytddnI5DTk3QVw7nm/uUwZMbBZDoJBLpebumuragd5RM5r
         googQ2RrtXQp25tvH4bgveXmU7Q7VJFoTFKRiKFBOreYYWKR2MWWG2FoQHVrgHyaK0r5
         zEaIYCs9LeZrAKITaVzqntQBaXSXizb1uI+BMuNuVOzPKMInS0jKMY3SnHprroXHoOn5
         43ww==
X-Gm-Message-State: AOJu0YxjqARwDhKH9p/RbsIF2GNJnX1Zg3ObQYxTiRUWOqlVJBim1TKu
	zZJ2+RKXHqhas672FSYEAAGuScmClYZaaJdmULngTSMKgXnQOyvYFKBdguWWm0jh08QLuTDVoVN
	MhRl7bHLSLZR0k9JuMYPI5OlH216GXfj2svjwVAPdcOjzC8BnrfmMduQ4Y4I=
X-Received: by 2002:a05:620a:2944:b0:785:9521:9603 with SMTP id n4-20020a05620a294400b0078595219603mr41457qkp.0.1707212207118;
        Tue, 06 Feb 2024 01:36:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkHldplqRxmO52+L+0eJA1m1uj5lNB4s/lraQFTlJXdSoQ8+eMUpZ3MxLcOt2DHo0CKDKGtg==
X-Received: by 2002:a05:620a:2944:b0:785:9521:9603 with SMTP id n4-20020a05620a294400b0078595219603mr41440qkp.0.1707212206863;
        Tue, 06 Feb 2024 01:36:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX0eTKyaNqU4MvNt6IPt9W+TM5FdOYvSlOLajLKFA2fW8GASp50CgRgqzJy77fGHzP9yOeUwO9ikj2fYEgJJLsLQdl9kxKq4o8tc3cAK9Mel02Ms9kSK23XBQHTBJ53pmBI8N4wE+go0Fh+3IFr1rfFQuMuO99odI+3nJImFay5fb2m4vKqe1ceYf7fsj2Gf1QI0LYbv8sOVezeWygJn/VB62Niy2i7UOS7hKJe6Ixx4S+LUvUVSCigmNC3SLNy82hrPzx+DVkZdfzBvnTwlQyqBvuwwg7Th4Rsym1aD75U9qdtaMhbN9gVR5EUGLZIklbgMT6yucWQT8PlYpf4vGZjoHvStofuQGec/WBk+zb4ICzA/62QGfP8hePqOHtB366RdqbFUICUAlY+QLg6dzMsk0rH9lED0/bJdZj1DT3QURaf6UIUTvCEUkgG7ILXnHxd+VdMZIegrl/Wa9Yddyz/F8L/Rl+84nqIpP9ihh2W3z4o/kcEOwrY8Rqxa3YwnBelLSpv7ewRnSIp3Q+ULAD9vdu+BpUHuhIGNN7Fd+2LKFUrEdj1tlaJ4LA6s6EC/wnanDBWIjtGPqg/b5KG9uXlceQmehYCeO5oVUxTuihcucKTaeYrhnkQpf25uSZgry4b5OPq36tkYEQwQMtDmLF3nds/1s9S+G7cBbHlVAHIF+uUznuW+seY0FapwWP3RLh7+0x/ugrK6TiK/ryiDuWYyxzj1T1vuBaMPDhGB1DAb72Yx6ToV18nmE26WUA4kY9aueYsX38HcddJw+59lDAy6xjITysumcSLrIy+Aoke05ZoDkEgvSlEncuA5p2vQB4tsWNI8zIZFWlW94Q9jDYf2AYNUY6riqeW
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id x7-20020a05620a0ec700b0078552f53b85sm750891qkm.86.2024.02.06.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:36:46 -0800 (PST)
Message-ID: <1797620e544e77cad9a8cc86d9145e1046d84e6b.camel@redhat.com>
Subject: Re: [PATCH v6 1/4] lib/pci_iomap.c: fix cleanup bug in pci_iounmap()
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Johannes Berg <johannes@sipsolutions.net>, Randy Dunlap
 <rdunlap@infradead.org>, NeilBrown <neilb@suse.de>,  John Sanpe
 <sanpeqf@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Dave Jiang <dave.jiang@intel.com>,
 Uladzislau Koshchanka <koshchanka@gmail.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, David Gow <davidgow@google.com>, Kees Cook
 <keescook@chromium.org>, Rae Moar <rmoar@google.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, "wuqiang.matt" <wuqiang.matt@bytedance.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>, Thomas
 Gleixner <tglx@linutronix.de>, Marco Elver <elver@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
 dakr@redhat.com, linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, stable@vger.kernel.org,  Arnd Bergmann
 <arnd@kernel.org>
Date: Tue, 06 Feb 2024 10:36:42 +0100
In-Reply-To: <20240131210944.GA599710@bhelgaas>
References: <20240131210944.GA599710@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 15:09 -0600, Bjorn Helgaas wrote:
> On Wed, Jan 31, 2024 at 10:00:20AM +0100, Philipp Stanner wrote:
> > The #ifdef for the ioport-ranges accidentally also guards
> > iounmap(),
> > potentially compiling an empty function. This would cause the
> > mapping to
> > be leaked.
> >=20
> > Move the guard so that iounmap() will always be part of the
> > function.
>=20
> I tweaked the subject and commit log to be more explicit about what
> the bug is.=C2=A0 Let me know if I got it wrong:

Mostly correct IMO

>=20
> =C2=A0 pci_iounmap(): Fix MMIO mapping leak
>=20
> =C2=A0 The #ifdef ARCH_HAS_GENERIC_IOPORT_MAP accidentally also guards
> iounmap(),
> =C2=A0 which means MMIO mappings are leaked.

nit: I wasn't entirely sure when they are actually leaked, just that
they _could_ be leaked. To know for sure we'd need to search who sets
ARCH_WANTS_GENERIC_PCI_IOUNMAP without setting
ARCH_HAS_GENERIC_IOPORT_MAP.

I think your formulation should be fine, though, since it's definitely
a bug.

P.

>=20
> =C2=A0 Move the guard so we call iounmap() for MMIO mappings.
>=20
> Bjorn
>=20


