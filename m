Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3C24FF5
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2019 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEUNS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 May 2019 09:18:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40795 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbfEUNS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 May 2019 09:18:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 15so2866132wmg.5
        for <linux-arch@vger.kernel.org>; Tue, 21 May 2019 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/t4nh9Qn5eHvWriEo2lAzUTm+cejgZEB4hMcOrCq4Y=;
        b=Qzja+tqWdJKwhlDJv7ZeHS1krNqDAM++eYcwAp+RKkbv8p1KDPWxxZhzOpavU0EOHV
         kYWbjNPEjkxc3aEKZdrk9785qJNa6FxJtfkDGm1FLt3j0bk9/8YvawePnukWGCyjpFii
         0DMW2p0x+5xPdVsJRuiSOe+/dtlaOGa52u2fWdq9QaNK4Tve8leR5ZqhEKAiqjWW0X06
         oTZk1e1uxbJPDBZIKsNtQKeWDeRpwtxnoV5XKv/I6zW+K9rGYAZZ7B8YjZBRwD4kYhWa
         WgDiIxwS5iY9PCvzQxN+w34XvRhk0st2I0ChEGvAZh7Cr4yOtxIXjdk5keUvD29dcq/r
         WLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/t4nh9Qn5eHvWriEo2lAzUTm+cejgZEB4hMcOrCq4Y=;
        b=fBoITNAOoH+OXGfRr1KfLl0CJMvj/iHecXZYSoFSp/ffnEK2K62gZEQ3PJiVc0bTuB
         0tnTaTieaKZ43HkavS5yAxO7Li9MActi+Swypi3pmlfXSIvdNeOVTBJ4J4z4mm9hxhPO
         oTnk5OBp8sL1Q5xhs27ordnOAYa4kBPDF/lgc1E78e2t7++k05n8w4zV58WyujKTDzVi
         y0R1eV4r36l32WXK8RU9ZdcZbRCtZCTvaqT6OT/uDS/nNkX7FD3Q4GogyzgLTkZHmw+S
         O9oXwYt40ZekUmeaf5SRPJWEV6dKIhcUGtyoZM2sm7fCnTSn4bxR8ORQ3U3R6w1vv+rZ
         YazA==
X-Gm-Message-State: APjAAAUolZwVeJOqhVB8xhhAjHwOUavxb6QC6+onliIjQjEJt8xNAc1T
        RCwQRD+cT2zqBWcUamynK3573g==
X-Google-Smtp-Source: APXvYqyfKPZSJeUKKvR/WsITTIjBfoMQuzQ5Xtre6YfbYN0C4pHfHkECFwZ8Y50hJAsIDs/Jg3fbyg==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr3258598wme.95.1558444734225;
        Tue, 21 May 2019 06:18:54 -0700 (PDT)
Received: from brauner.io (p548C9938.dip0.t-ipconnect.de. [84.140.153.56])
        by smtp.gmail.com with ESMTPSA id n4sm2071899wmk.24.2019.05.21.06.18.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 06:18:53 -0700 (PDT)
Date:   Tue, 21 May 2019 15:18:50 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org,
        miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
Message-ID: <20190521131849.2mguu5sszhbxhvgu@brauner.io>
References: <20190521113448.20654-1-christian@brauner.io>
 <87tvdoau12.fsf@oldenburg2.str.redhat.com>
 <20190521130438.q3u4wvve7p6md6cm@brauner.io>
 <87h89o9cng.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h89o9cng.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 21, 2019 at 03:10:11PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> >> Solaris has an fdwalk function:
> >> 
> >>   <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>
> >> 
> >> So a different way to implement this would expose a nextfd system call
> >
> > Meh. If nextfd() then I would like it to be able to:
> > - get the nextfd(fd) >= fd
> > - get highest open fd e.g. nextfd(-1)
> 
> The highest open descriptor isn't istering for fdwalk because nextfd
> would just fail.
> 
> > But then I wonder if nextfd() needs to be a syscall and isn't just
> > either:
> > fcntl(fd, F_GET_NEXT)?
> > or
> > prctl(PR_GET_NEXT)?
> 
> I think the fcntl route is a bit iffy because you might need it to get
> the *first* valid descriptor.

Oh, how would that be difficult? Maybe I'm missing context.
Couldn't you just do

fcntl(0, F_GET_NEXT)

> 
> >> to userspace, so that we can use that to implement both fdwalk and
> >> closefrom.  But maybe fdwalk is just too obscure, given the existence of
> >> /proc.
> >
> > Yeah we probably don't need fdwalk.
> 
> Agreed.  Just wanted to bring it up for completeness.  I certainly don't
> want to derail the implementation of close_range.

No, that's perfectly fine. I mean, you clearly need this and are one of
the major stakeholders. For example, Rust (probably also Python) will
call down into libc and not use the syscall directly. They kinda do this
with getfdtable<sm> rn already.
So what you say makes sense for libc has some relevance for the other
tools as well.

Christian
