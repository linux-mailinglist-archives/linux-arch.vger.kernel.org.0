Return-Path: <linux-arch+bounces-11969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B690DAB94D8
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 05:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A17500792
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 03:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA127221FCB;
	Fri, 16 May 2025 03:43:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61E157E6B;
	Fri, 16 May 2025 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747366980; cv=none; b=CEClNoo70gIVk4zgrvw004i6SdS9qiQpZZiO4HrRy3Dk+cTtkitFp4beM6S0SE5pUSiuTnnYhQaTMpoIFLT0pvKmWTIquluFEfxjDl/oyKTQ6EnKauGSAbnPAMFSvwftEMDGnAemYzlweyuLzza/ChcURqeK9t3NUYih0q5fjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747366980; c=relaxed/simple;
	bh=OVkUQi0BOxewrN/TcrPE7P8qoc+l5nR7NbzjdSJwhTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ly5DA6mFIhYYUvnuf8rMyqDJzi1+8riQUuWLYSuuzhZnCWovOcTiRPasiEmz4Px8ix8se9roryTPa1blmtYL/y0slvxntwQdvgYwP6r1XVHjmseZlWH615iIpYcwyP297Vkz3xGTv1Xf93aviqWTnieDrpm7Q7+rOlvrPxmd6Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 54G3gWRw012606;
	Fri, 16 May 2025 05:42:32 +0200
Date: Fri, 16 May 2025 05:42:32 +0200
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: enh <enh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Subject: Re: Metalanguage for the Linux UAPI
Message-ID: <20250516034232.GA12472@1wt.eu>
References: <feb98a0f-8d17-495c-b556-b4fe19446d5d@zytor.com>
 <CAJgzZoqUV6gSfgCWbfe6oSH5k9qt30gpJ0epa+w78WQUgTCqNQ@mail.gmail.com>
 <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4d114e3-984a-482d-a162-03f896cd2053@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, May 15, 2025 at 02:24:29PM -0700, H. Peter Anvin wrote:
> On 5/15/25 13:26, enh wrote:
> > On Thu, May 15, 2025 at 4:05 PM H. Peter Anvin <hpa@zytor.com> wrote:
> > > 
> > > OK, so this is something I have been thinking about for quite a while.
> > > It would be a quite large project, so I would like to hear people's
> > > opinions on it before even starting.
> > > 
> > > We have finally succeeded in divorcing the Linux UAPI from the general
> > > kernel headers, but even so, there are a lot of things in the UAPI that
> > > means it is not possible for an arbitrary libc to use it directly; for
> > > example "struct termios" is not the glibc "struct termios", but
> > > redefining it breaks the ioctl numbering unless the ioctl headers are
> > > changed as well, and so on. However, other libcs want to use the struct
> > > termios as defined in the kernel, or, more likely, struct termios2.
> > 
> > bionic is a ("the only"?) libc that tries to not duplicate _anything_
> > and always defer to the uapi headers. we have quite an extensive list
> > of hacks we need to apply to rewrite the uapi headers into something
> > directly usable (and a lot of awful python to apply those hacks):
> > 
> > https://cs.android.com/android/platform/superproject/main/+/main:bionic/libc/kernel/tools/defaults.py
> > 
> 
> Not "the only".

Indeed, nolibc (/tools/include/nolibc) directly includes uapi as well, and
since nolibc doesn't compile anything but only exposes include files, these
appear as-is in the application. So far the headers look clean enough for
our use cases and have not caused problems. But admittedly, applications
are small and limited (selftests and init code).

One thing we've been considering which we would find convenient there
would be to generate an indirection layer for all files that would include
the right one depending on the detected arch so as to ease compilation for
any arch with all the uapi files available, as it seems totally feasible
right now (i.e. each .h file would just have "#if defined(__arch_xxx__)
#include <arch_xxx/foo.h>" etc). We could imagine having a
"make install-all-headers" target to produce that thing for example. I'm
sharing this so that you can also have this in mind to consider whether or
not your chosen approach would break that possibility.

Just my two cents,
Willy

