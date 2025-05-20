Return-Path: <linux-arch+bounces-12024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC82ABDFEF
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 18:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704144C0124
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547825FA3B;
	Tue, 20 May 2025 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqW2yWV3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9A1A83FB
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757128; cv=none; b=HKT1dwvjyVngPeiKjhK/2FEUIwClyWA4/UHNbcbkXfRwrl4Be8W8lh9V/Mb70XYUmZfmYiIpQf1/A4Ex3TjH6FvnPJ96VgGa4+jRZcpME6TSAh7o+dH0lTWuJK7PU/JdKkkvGZizQEFCB0KvxXuPIKzSiPqzZzciUH5afb3t5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757128; c=relaxed/simple;
	bh=0rfntWFazho4mK9F9eshENfRLYtOEx0ULfCoFJCPcTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC7qC8Wwbjy2NCFyHWvWBQDsTahS6ZTzz9W4LJ/9CjcGF6EfgELCJtLHTmzMVFFOL69tD/xnfsin0i7BbyUxOImcBmK8ADYAWR7TSScX9i8ZPe0GjSv3sBDn4Z6r0qIH5RRuyIOTGGtLEzReCaIjFxMVmshSoiDXzmoNeYUzaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqW2yWV3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fab85c582fso26388a12.0
        for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747757125; x=1748361925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rfntWFazho4mK9F9eshENfRLYtOEx0ULfCoFJCPcTU=;
        b=kqW2yWV3/des5oSs+TsccmywePxPMs85qL4X11mUSfxkOCeOUGQxSGaGZwAYPVLAEk
         enZCuOxKX9gHsBNqnxbho+ZK32XuDKYwk+hrqRlR7Ry0etACraWmY9bvR1P7Vb7TKO8B
         VvJHj7M+4K53hMreXlO8K7BHHcdeUzY2W2dejDnN2slM3CA6UQTKv9aa+KR5sI7xIKyE
         OjUE1yzf/j00KGeZaxdoqJ/Y93p5mdV+qzFzlPdV6HRTHn+HDD6F6tWxFGKigx9RCk0m
         zqJEXP2c0P4N+qlqGJJyjpIRQNQDQQEnyDlBCCjSfLH9ceibFMOFJPyBiT5Z+zcYMYUr
         PVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757125; x=1748361925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rfntWFazho4mK9F9eshENfRLYtOEx0ULfCoFJCPcTU=;
        b=oXIi/f/0KAkZXI/PZ9soa9med2KdIqTtX/x8Ao4fLmiEzysSCAqPo0LSLlXrn6Q8h7
         ts0AZ7cvVZdHSCHhcCRmoYxeo4Bvvwc8iRfnnk3jRBzDR2UWHcFTYLBF2KEZgZg8Px++
         z/ze2t4IOcNdz21MDeA356ABiJzhC3Rn/ThRcon0qTIKML0qvBAibB5jeK7pdcYSZn6t
         sKFW+GqBtRZ/pI3Xf/9FFNPUqO+R7jb+hfdaBkhl/rtnF11KRDMU5B8Py8gopcIDxHiG
         Y69viPo74+EXx/qFFEl4d+KWg6QEZzMUTHgGjJIOFxR3MDJGsg49ov/EQK+11jFgZ3gU
         s8/A==
X-Forwarded-Encrypted: i=1; AJvYcCVm03fcmJvcFKi0LKZX8lxnmAglAM3fmOp3GSQOd5yYbv2AHHuDujKmjK3doHhjQ8BEhWk3g1PAlrqw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3h5ehKqye5F8gCyuyATH1L0MgzdHK1ipQq3WxovLI5s9CJdj0
	iIX7wsKkmgUUxdAShdv+EIp0MUKt23Gv2WAvg9krr6+fNTR/YR4qYlf0j9wdKesuZ1suuTCgwLe
	yR1uT0aON433zgs/2xfMPy61YcrowRliIIw0UmmE9
X-Gm-Gg: ASbGncvOhb7QrtEDZ4LkYQkDHzMJD9MIAKwNCLT4XGIIfxGMMwJJgUzcNdG2Plai3CP
	By081NRXLgj+iu9KWjEOPVivvtMAg5DilpLhzt2gjNICdWLXOckSOr68Z6hg0WL1zJ81K1O9bJu
	Amlud7zif8ThGyr0QmJHf6piihWgbi6m9zBc/Ix2k8gSQK+rxVjM7EIYXz4XIYD8VRBUKn2A==
X-Google-Smtp-Source: AGHT+IEOQ2vFE3jecYWUn3oKnGtTWjIT++RWO5aGS6gOAXZFLqR0bXLZnvv/yrhnUofHKsIUGByrvi7YUdoaE5rGLCU=
X-Received: by 2002:aa7:dd08:0:b0:600:9008:4a40 with SMTP id
 4fb4d7f45d1cf-6019c88648dmr301495a12.4.1747757124254; Tue, 20 May 2025
 09:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com> <368b0ca0-605e-4d2b-b12e-c24b1734d1c2@lucifer.local>
In-Reply-To: <368b0ca0-605e-4d2b-b12e-c24b1734d1c2@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Tue, 20 May 2025 18:04:47 +0200
X-Gm-Features: AX0GCFsPdY0pLyAGHK-EG0PUc1QDFfH1ipfBEhtjta5dZf6rJFGtFMXyimrWtdo
Message-ID: <CAG48ez0RKgQwpE07tZ8WcfH5XCeZ26wVOZa26HdYjADzVbHbgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 7:36=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Mon, May 19, 2025 at 11:53:43PM +0200, Jann Horn wrote:
> > For comparison, personality flags are explicitly supposed to persist
> > across execve, but they can be dangerous (stuff like READ_IMPLIES_EXEC
> > and ADDR_NO_RANDOMIZE), so we have PER_CLEAR_ON_SETID which gets
> > cleared only if the execution is privileged. (Annoyingly, the
> > PER_CLEAR_ON_SETID handling is currently implemented separately for
> > each type of privileged execution we can have
> > [setuid/setgid/fscaps/selinux transition/apparmor transition/smack
> > transition], but I guess you could probably gate it on
> > bprm->secureexec instead...).
> >
> > It would be nice if you could either make this a property of the
> > mm_struct that does not persist across exec, or if that would break
> > your intended usecase, alternatively wipe it on privileged execution.
>
> The use case specifically requires persistence, unfortunately (we are sti=
ll
> determining whether this makes sense however - it is by no means a 'done
> deal' that we're accepting this as a thing).
>
> I suppose wiping on privileged execution could be achieved by storing a
> mask of these permitted flags and clearing that mask in mm->def_flags at
> this point?

Oh, I see, we're already inheriting VM_NOHUGEPAGE on execve through
mm->def_flags, with the bitmask VM_INIT_DEF_MASK controlling what is
inheritable? Hmmmm... I guess turning hugepages _off_ should be
fine...

Yeah I guess I'd do this by adding another bitmask
VM_INIT_DEF_MASK_SECUREEXEC or something like that, and then applying
that bitmask on setuid execution.

