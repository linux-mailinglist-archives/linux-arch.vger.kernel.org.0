Return-Path: <linux-arch+bounces-8430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256F9AB743
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 21:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC109B22C5E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF901CBEA6;
	Tue, 22 Oct 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isaIfpbx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F01C9DD7
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627099; cv=none; b=eauLQzu2AZZS+9H6aC5AUhwU63b/TdDS4e9Nxp8ErNKHZ1vyZSkMEu4N4b7evHVPPSPO/W9Q0gLoHZY6p8Qz+aelu57jmWAra6n+jqs8bEJiA3XoBbfuv3poRwlLC7Pgwes4zn9ikwo+mY+XBBeWOyIKkiPVFT3jDohsqduiHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627099; c=relaxed/simple;
	bh=xkDklXPQlr4HBd8TsidmEPMdu+Yvhj+vb3uSwdwtaEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9yJNyp7qYa5Uz8uJnHMITYqrBeJ8kIR+Dz62u6TSF/dlaEOKArAWoxawFITtG010VliVfUvnxR0KpwxBStXoXAw2llnl7fJfXeJhb7BTUmDECROsOSoTWITxx+TXM2/2iXJiiFAJegTKlMmThElZZQvgNgIWnZgTk3zA4DHM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isaIfpbx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso8275e9.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729627096; x=1730231896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI9a6JxWBBH+S3C6zR+p95GIu67ToNwJVnSyMsWGv7s=;
        b=isaIfpbxiVd9X8rz63TDlvpNTzypGlBt4QBE6DvWbe1P1h0e/O+2AKSPNGyaN+NLtk
         eHSfv/QwDswnWs7WHpFylzDa5aRtv7lakCWRl6u5/nrylFVpjqxzgH13M9WF4lYkmEj3
         JzxqK5imCYvXwKL65NIT+eFu/Vso5l7vbhGO1vCRPhIOwAjD68yON6FDK+8R+qeE1Y2O
         hFyvcvxFm1Av6AiXubxfVNCPja9IUhuyY65sPTRS6XBBEXtEOxYlUmqAZfNmK+ybQWrW
         0pbV6gKuYGLDdaLfTxvnm/uFQb72leFtR7zCJrlFNdl4/YVSALHXsCCh4iNOW0T4I+7i
         92oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627096; x=1730231896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI9a6JxWBBH+S3C6zR+p95GIu67ToNwJVnSyMsWGv7s=;
        b=ku8tkWvRjV50yOPYlnw/gDQyt5APdYuHz90X2+mv8l+ot//sGnBTpZ4E+5cB3R1StH
         axlCEP1uTQkMXHZWOIDkRQ2qnY3SW/BhK3rHbAY2HFuY4wJ7booFZh+wRR8Oe5tzDrWV
         8iCtssQPOo9ymTxjkg8fqhIXFXaSIthBTuUB+NgvEVKAzOVoHut9A8DHCC/a2vqeoKeB
         zMjwbqrxDGzzuOjAttO+RpUML5BJq9sf+skZcpSSdFfoIA0uAoJ4J1GDlN0pidQ9S4gw
         TuHrs6b7uWJJDGVs3jlI5woUdQ6fxNCHG0IoibOEUXimLRNNHQVyNuzFyfk601xiVdoj
         xqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCKbSbblxNyKZ9ujoeLq6yHJ299JqoWpPfrE08yAAL9shy1Yg3IdfYVB1My2L75FwVXJ5nOPgHB39U@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/uZzu+NGaB9zuYzy4ZPQ6/MHMkxQfpOc8sdd3yrQKOq5HPZi
	70wmaH2rOvQ/VgDcRTCI6MvL+eflreIh0P8sNTV/7O7+p3NBq/VQbH+GRk3s5EhSjQVxgj1O/aV
	JTLZ82MZ1VKzLYmcCrhEztKw8obqxa+gPx0kd
X-Google-Smtp-Source: AGHT+IFeWIyT88dGlsdB6/p06aq90kLyVYjy4rjrqh6CY+sRs1htAUUVZyjMS+uR8oPhtq3VpqNiR+I6FEIsDJOzmq4=
X-Received: by 2002:a05:600c:4e4e:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-4318479635dmr176525e9.7.1729627095385; Tue, 22 Oct 2024
 12:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz> <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
 <f2448c59-0456-49e8-9676-609629227808@suse.cz> <CAG48ez3WS3EH9DuhE1b+7AX3+1=dVtd1M7y_5Ev4Shp2YxiYWg@mail.gmail.com>
 <2647d37b-3482-4fc9-8da2-1158ebdc919e@lucifer.local>
In-Reply-To: <2647d37b-3482-4fc9-8da2-1158ebdc919e@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Oct 2024 21:57:39 +0200
Message-ID: <CAG48ez2rrHeq5aNPA9pB-1T6n1WjCh+g+8Hp4QrZemqVb6UsYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:35=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Tue, Oct 22, 2024 at 09:08:53PM +0200, Jann Horn wrote:
> > On Mon, Oct 21, 2024 at 10:46=E2=80=AFPM Vlastimil Babka <vbabka@suse.c=
z> wrote:
> > > On 10/21/24 22:27, Lorenzo Stoakes wrote:
> > > > On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
> > > >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > > >> > +  while (true) {
> > > >> > +          /* Returns < 0 on error, =3D=3D 0 if success, > 0 if =
zap needed. */
> > > >> > +          err =3D walk_page_range_mm(vma->vm_mm, start, end,
> > > >> > +                                   &guard_poison_walk_ops, NULL=
);
> > > >> > +          if (err <=3D 0)
> > > >> > +                  return err;
> > > >> > +
> > > >> > +          /*
> > > >> > +           * OK some of the range have non-guard pages mapped, =
zap
> > > >> > +           * them. This leaves existing guard pages in place.
> > > >> > +           */
> > > >> > +          zap_page_range_single(vma, start, end - start, NULL);
> > > >>
> > > >> ... however the potentially endless loop doesn't seem great. Could=
 a
> > > >> malicious program keep refaulting the range (ignoring any segfault=
s if it
> > > >> loses a race) with one thread while failing to make progress here =
with
> > > >> another thread? Is that ok because it would only punish itself?
> > > >
> > > > Sigh. Again, I don't think you've read the previous series have you=
? Or
> > > > even the changelog... I added this as Jann asked for it. Originally=
 we'd
> > > > -EAGAIN if we got raced. See the discussion over in v1 for details.
> > > >
> > > > I did it that way specifically to avoid such things, but Jann didn'=
t appear
> > > > to think it was a problem.
> > >
> > > If Jann is fine with this then it must be secure enough.
> >
> > My thinking there was:
> >
> > We can legitimately race with adjacent faults populating the area
> > we're operating on with THP pages; as long as the zapping and
> > poison-marker-setting are separate, *someone* will have to do the
> > retry. Either we do it in the kernel, or we tell userspace to handle
> > it, but having the kernel take care of it is preferable because it
> > makes the stable UAPI less messy.
> >
> > One easy way to do it in the kernel would be to return -ERESTARTNOINTR
> > after the zap_page_range_single() instead of jumping back up, which in
> > terms of locking and signal handling and such would be equivalent to
> > looping in userspace (because really that's what -ERESTARTNOINTR does
> > - it returns out to userspace and moves the instruction pointer back
> > to restart the syscall). Though if we do that immediately, it might
> > make MADV_POISON unnecessarily slow, so we should probably retry once
> > before doing that. The other easy way is to just loop here.
>
> Yes we should definitely retry probably a few times to cover the rare
> situation of a THP race as you describe under non-abusive circumstances.
>
> >
> > The cond_resched() and pending fatal signal check mean that (except on
> > CONFIG_PREEMPT_NONE) the only differences between the current
> > implementation and looping in userspace are that we don't handle
> > non-fatal signals in between iterations and that we keep hogging the
> > mmap_lock in read mode. We do already have a bunch of codepaths that
> > retry on concurrent page table changes, like when zap_pte_range()
> > encounters a pte_offset_map_lock() failure; though I guess the
> > difference is that the retry on those is just a couple instructions,
> > which would be harder to race consistently, while here we redo walks
> > across the entire range, which should be fairly easy to race
> > repeatedly.
> >
> > So I guess you have a point that this might be the easiest way to
> > stall other tasks that are trying to take mmap_lock for an extended
> > amount of time, I did not fully consider that... and then I guess you
> > could use that to slow down usercopy fault handling (once the lock
> > switches to handoff mode because of a stalled writer?) or slow down
> > other processes trying to read /proc/$pid/cmdline?
>
> Hm does that need a write lock?

No, but if you have one reader that is hogging the rwsem, and then a
writer is queued up on the rwsem afterwards, I think new readers will
sometimes be queued up behind the writer. So even though the rwsem is
only actually held by a reader, new readers can't immediately take the
rwsem because the rwsem code thinks that would be unfair to a pending
writer who just wants to make some quick change. I'm not super
familiar with this code, but basically I think it works roughly like
this:

If the rwsem code notices that a bunch of readers are preventing a
writer from taking the lock, the rwsem code will start queuing new
readers behind the queued writer. You can see in rwsem_read_trylock()
that the trylock fastpath is skipped if anyone is waiting on the rwsem
or the handoff flag is set, and in rwsem_down_read_slowpath() the
"reader optimistic lock stealing" path is skipped if the lock is
currently held by multiple readers or if the handoff bit is set.

The handoff bit can be set in rwsem_try_write_lock() by a writer "if
it is an RT task or wait in the wait queue for too long". Basically I
think it means something like "I think other users of the lock are
hogging it more than they should, stop stealing the lock from me".
And the RWSEM_WAIT_TIMEOUT for triggering handoff mode is pretty
short, RWSEM_WAIT_TIMEOUT is defined to something like 4ms, so I think
that's how long writers tolerate the lock being hogged by readers
before they prevent new readers from stealing the lock.

