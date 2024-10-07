Return-Path: <linux-arch+bounces-7777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A09933AD
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE621C2326D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35D1D9582;
	Mon,  7 Oct 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXePPTq4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BE1DB52F
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319548; cv=none; b=LY5Y0QjFwaL79Vm14TSGpeveftwrbdHLM0KVIoXm1WLflEDxdh/Nx4o2pFUxJK1o8whjV3v+7qdOWzzUxUUc9drXm3Tg1XguViKNCfQGYfjppoMtjUdPR73uye1fvFWMuQ5QF/2+8buZovcj4z+RuzScNtnKFyT9ShVFWRvSZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319548; c=relaxed/simple;
	bh=/7ztko93ajz3br8UFXDL1lZr8JEVrLlN0ZTViF/M0ZE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jSa3kT+iC8AFdC+GpsJkiXZV67dOPe16Z/JIKLsIIz+Maekc1Dov0rYlqElkX+SXJ8JmNT1/QQHgcAoaZwx6Bb3EtmQoxpB67fH3wz6ETlX6AExxTQ7N8ztT51h8vLt/KCe0cRCg6xSawqVjMHIYeSusYU76kWSxUtLKPgD5+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXePPTq4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e18d5b9a25so5986717a91.2
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728319546; x=1728924346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnvskd1UMKG/zIpThM4lfsmOmZwPeMRMLKnKM1lSsPQ=;
        b=xXePPTq4RR/z0SZpU8eiJGE0S884yjaFLnLU3m6V4+AYbqFG4h3JGpxyRaijtlgLCK
         JjmhN1+6lVrBL4Wl33p6Quh/93MPHXxveGi1eW2G2lX5u0+iiXnpiyw0CfsuB7EHO3YV
         j0IBNyGOwO4oUnMahW0LfiYR0yCF/+cMDNdRWlxGHaSWwyi6r3SoVtDly5/3Y3EzbJ/b
         9RSPpVeCZ+sehzEnFLzzKcM+i84ndUHRKv9NRi48/WYh6n/gfrUHv+GepOb46sO6kFEZ
         P4OKQROCEGU9MC5XfQ1m1v/HN8EB/betFLfaRm5WxyjQ47I46BIDMV0mem0wEw1ov9g6
         053Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319546; x=1728924346;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mnvskd1UMKG/zIpThM4lfsmOmZwPeMRMLKnKM1lSsPQ=;
        b=BEdQN5J0J+HESoktl2duz6YBC5oVMhGUE0C8LrVHdaOOl2kS4ys/MixXTTKMdTL7Gh
         qoIS8uNoNDgTeuEO5KpxChLpGMNJSmOCSNiZiLuIX2vMDgqHkc7yu6bl9Ty1MpzDlxro
         rtBxvUQN5yb+OkMjPbYkWG1ByBeSRP/Ue1Hn0hiYOOhzZ8GHgyoVlLGPAmi8kv8E3ksY
         Cotb9qGFNAUEGUjCvUEr6gwE96SqJMr0rlfSWlhxENDEMpo86DyY4oqFfB4uVpuZMX+Z
         okztkgyBo/suJX44CISf6dGa1fTMjJJEvvKJkLT4izNP1NnQb114t0O5pD7LK1MAT3lM
         w40Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPJYsFPVut/tBjARAhH9sNvSWSSy0oIbrS6q3/PL9c/nT2BH8AV2kqck27X75gtgqQPmYUU+DnIAig@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ArPw7yCi0MY13IeJNkOi//B4zYk0CHdfmsqoBoTLMD7dEhqp
	wXyPmykP1KYZR4a6KAxT1fbMMX6to2pcPOfeYNLWb8/rIQZfW+RhhWspJT0fY60SOIzSXLDZA8n
	XGQ==
X-Google-Smtp-Source: AGHT+IFiIQrhwfP2AODONDAi/MWD5bThgV6AEO8qEDkrjI6w861ThE+bO5hmJB1ie46Q71cAIh+U1THO8Rc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7807:b0:2e1:e8d7:1947 with SMTP id
 98e67ed59e1d1-2e1e8d719d8mr42978a91.1.1728319546131; Mon, 07 Oct 2024
 09:45:46 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:45:44 -0700
In-Reply-To: <7c13be04-1d18-45bd-8cfc-f5d37bd39a8e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com> <8c7fbaf1-61a0-4f55-8466-1ab40464d9db@redhat.com>
 <0a1678d8-0974-4783-a6f6-da85adfa1a34@intel.com> <7c13be04-1d18-45bd-8cfc-f5d37bd39a8e@redhat.com>
Message-ID: <ZwQQOP89Dj5gvbaP@google.com>
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
From: Sean Christopherson <seanjc@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, khalid@kernel.org, andreyknvl@gmail.com, 
	luto@kernel.org, brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024, David Hildenbrand wrote:
> On 07.10.24 17:58, Dave Hansen wrote:
> > On 10/7/24 01:44, David Hildenbrand wrote:
> > > On 02.10.24 19:35, Dave Hansen wrote:
> > > > We were just chatting about this on David Rientjes's MM alignment c=
all.
> > >=20
> > > Unfortunately I was not able to attend this time, my body decided it'=
s a
> > > good idea to stay in bed for a couple of days.
> > >=20
> > > > I thought I'd try to give a little brain
> > > >=20
> > > > Let's start by thinking about KVM and secondary MMUs.=C2=A0 KVM has=
 a primary
> > > > mm: the QEMU (or whatever) process mm.=C2=A0 The virtualization (EP=
T/NPT)
> > > > tables get entries that effectively mirror the primary mm page tabl=
es
> > > > and constitute a secondary MMU.=C2=A0 If the primary page tables ch=
ange,
> > > > mmu_notifiers ensure that the changes get reflected into the
> > > > virtualization tables and also that the virtualization paging struc=
ture
> > > > caches are flushed.
> > > >=20
> > > > msharefs is doing something very similar.=C2=A0 But, in the msharef=
s case,
> > > > the secondary MMUs are actually normal CPU MMUs.=C2=A0 The page tab=
les are
> > > > normal old page tables and the caches are the normal old TLB.=C2=A0=
 That's
> > > > what makes it so confusing: we have lots of infrastructure for deal=
ing
> > > > with that "stuff" (CPU page tables and TLB), but msharefs has
> > > > short-circuited the infrastructure and it doesn't work any more.
> > >=20
> > > It's quite different IMHO, to a degree that I believe they are differ=
ent
> > > beasts:
> > >=20
> > > Secondary MMUs:
> > > * "Belongs" to same MM context and the primary MMU (process page tabl=
es)
> >=20
> > I think you're speaking to the ratio here.  For each secondary MMU, I
> > think you're saying that there's one and only one mm_struct.  Is that r=
ight?
>=20
> Yes, that is my understanding (at least with KVM). It's a secondary MMU
> derived from exactly one primary MMU (MM context -> page table hierarchy)=
.

I don't think the ratio is what's important.  I think the important takeawa=
y is
that the secondary MMU is explicitly tied to the primary MMU that it is tra=
cking.
This is enforced in code, as the list of mmu_notifiers is stored in mm_stru=
ct.

The 1:1 ratio probably holds true today, e.g. for KVM, each VM is associate=
d with
exactly one mm_struct.  But fundamentally, nothing would prevent a secondar=
y MMU
that manages a so called software TLB from tracking multiple primary MMUs.

E.g. it wouldn't be all that hard to implement in KVM (a bit crazy, but not=
 hard),
because KVM's memslots disallow gfn aliases, i.e. each index into KVM's sec=
ondary
MMU would be associated with at most one VMA and thus mm_struct.

Pulling Dave's earlier comment in:

 : But the short of it is that the msharefs host mm represents a "secondary
 : MMU".  I don't think it is really that special of an MMU other than the
 : fact that it has an mm_struct.

and David's (so. many. Davids):

 : I better not think about the complexity of seconary MMUs + mshare (e.g.,
 : KVM with mshare in guest memory): MMU notifiers for all MMs must be
 : called ...

mshare() is unique because it creates the possibly of chained "secondary" M=
MUs.
I.e. the fact that it has an mm_struct makes it *very* special, IMO.

> > > * Maintains separate tables/PTEs, in completely separate page table
> > >  =C2=A0 hierarchy
> >=20
> > This is the case for KVM and the VMX/SVM MMUs, but it's not generally
> > true about hardware.  IOMMUs can walk x86 page tables and populate the
> > IOTLB from the _same_ page table hierarchy as the CPU.
>=20
> Yes, of course.

Yeah, the recent rework of invalidate_range() =3D> arch_invalidate_secondar=
y_tlbs()
sums things up nicely:

commit 1af5a8109904b7f00828e7f9f63f5695b42f8215
Author:     Alistair Popple <apopple@nvidia.com>
AuthorDate: Tue Jul 25 23:42:07 2023 +1000
Commit:     Andrew Morton <akpm@linux-foundation.org>
CommitDate: Fri Aug 18 10:12:41 2023 -0700

    mmu_notifiers: rename invalidate_range notifier
   =20
    There are two main use cases for mmu notifiers.  One is by KVM which us=
es
    mmu_notifier_invalidate_range_start()/end() to manage a software TLB.
   =20
    The other is to manage hardware TLBs which need to use the
    invalidate_range() callback because HW can establish new TLB entries at
    any time.  Hence using start/end() can lead to memory corruption as the=
se
    callbacks happen too soon/late during page unmap.
   =20
    mmu notifier users should therefore either use the start()/end() callba=
cks
    or the invalidate_range() callbacks.  To make this usage clearer rename
    the invalidate_range() callback to arch_invalidate_secondary_tlbs() and
    update documention.

