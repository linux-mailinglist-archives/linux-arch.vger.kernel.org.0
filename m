Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23F39454A
	for <lists+linux-arch@lfdr.de>; Fri, 28 May 2021 17:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhE1Po1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 May 2021 11:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54485 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234187AbhE1Po0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 May 2021 11:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622216571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=aMiAGVAEjSCDtfuPEiNlfB4WzHDJXlnWiW+cA2agfALKPvSJ4LS4dc9YAc1CrBWGVdLmOY
        g4xRAZpV5A4hQc/4Njq6ZY0amSHGqqBCcG35MnFsJd/NJ7kNwUY2BJzDBneX1ggXv6ZkHL
        v65UdhEACJYcFh2udi7kDnQ8NT6eKBo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-m5mmjPvKOW2YlIAmSzRXkw-1; Fri, 28 May 2021 11:42:50 -0400
X-MC-Unique: m5mmjPvKOW2YlIAmSzRXkw-1
Received: by mail-ej1-f71.google.com with SMTP id gv42-20020a1709072beab02903eab8e33118so219770ejc.19
        for <linux-arch@vger.kernel.org>; Fri, 28 May 2021 08:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sC/4mqGVwjGmarPwyWnSGWMjis6RsnduR1OTuOfsgPQ=;
        b=CZOJWEhOrftVr7JhGFRwT1/aHhS8vMTf+OgrN6PbgeigOsS5N1ivi50dxefddKScGV
         qibpqP7f1Gp4lABPLTi0hzJm7sKt4aF0cla5NrROCQnZTBOeZEfqmndzkD38SL15kmPd
         JGzmSuyKg6AYezBL6bLvpXu/NlOZz0j4S5SyHQzHDVk92I5F6xJEprSvLVFlC1+WnKs7
         yrZkUoOyhLWj1v6sHhdWAV9c79vsHWzN/tCqUP5eF8dDQN1tMxs2rc2eAeefMXMEaGnQ
         oftYh0rTkLxZ6Ly7vWevqZLe9/n7X9ByBhYZMohFcO9N2yXg1WcZs44NSCDm3y4JmjGk
         H0JA==
X-Gm-Message-State: AOAM530mZPnJbSIZAP97IUHVf2fbiUhCKzjF/sfYHAljxYy8ndT6AEyO
        PjzT+M7/qHTABPUOc6soA9AlZwhAjCRHpjXxNsy2mO03WdRB4qdDKh3m1Q4BuzwXGw10fKzqnGc
        9TZgQ1Dh0UCgAtqqwlmTaXg==
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813397edi.126.1622216569044;
        Fri, 28 May 2021 08:42:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyh7puphKWIHAhTU3NrGDcpIPKc1l/cTOKXvbBu9zHj9YOh1870e+pFMIR14K/Zqb2VV4uAA==
X-Received: by 2002:a50:d589:: with SMTP id v9mr10813361edi.126.1622216568644;
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v24sm2839644eds.19.2021.05.28.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 08:42:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 86A4A180720; Fri, 28 May 2021 17:42:47 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>, Christoph Lameter <cl@gentwo.de>,
        Theodore Ts'o <tytso@mit.edu>, Jiri Kosina <jikos@kernel.org>,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Maintainers / Kernel Summit 2021 planning kick-off
In-Reply-To: <YLEIKk7IuWu6W4Sy@casper.infradead.org>
References: <YH2hs6EsPTpDAqXc@mit.edu>
 <nycvar.YFH.7.76.2104281228350.18270@cbobk.fhfr.pm>
 <YIx7R6tmcRRCl/az@mit.edu>
 <alpine.DEB.2.22.394.2105271522320.172088@gentwo.de>
 <YK+esqGjKaPb+b/Q@kroah.com>
 <c46dbda64558ab884af060f405e3f067112b9c8a.camel@HansenPartnership.com>
 <YLEIKk7IuWu6W4Sy@casper.infradead.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 28 May 2021 17:42:47 +0200
Message-ID: <87im32g8zs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, May 28, 2021 at 07:58:10AM -0700, James Bottomley wrote:
>> On Thu, 2021-05-27 at 15:29 +0200, Greg KH wrote:
>> > On Thu, May 27, 2021 at 03:23:03PM +0200, Christoph Lameter wrote:
>> > > On Fri, 30 Apr 2021, Theodore Ts'o wrote:
>> > > 
>> > > > I know we're all really hungry for some in-person meetups and
>> > > > discussions, but at least for LPC, Kernel Summit, and
>> > > > Maintainer's Summit, we're going to have to wait for another
>> > > > year,
>> > > 
>> > > Well now that we are vaccinated: Can we still change it?
>> > > 
>> > 
>> > Speak for yourself, remember that Europe and other parts of the world
>> > are not as "flush" with vaccines as the US currently is :(
>> 
>> The rollout is accelerating in Europe.  At least in Germany, I know
>> people younger than me are already vaccinated.  I think by the end of
>> September the situation will be better ... especially if the EU and US
>> agree on this air bridge (and the US actually agrees to let EU people
>> in).
>> 
>> One of the things Plumbers is thinking of is having a meetup at what
>> was OSS EU but which is now in Seattle.  The Maintainer's summit could
>> do the same thing.  We couldn't actually hold Plumbers in Seattle
>> because the hotels still had masks and distancing requirements for
>> events that effectively precluded the collaborative aspects of
>> microconferences, but evening events will be governed by local
>> protocols, rather than the Hotel, which are already more relaxed.
>
> Umm.  Let's remember that the vaccines are 33-93% effective [1],
> which means that there's approximately a 100% certainty that at least
> one person arriving at the event from a trans-atlantic flight has been
> exposed to someone who has the virus.  I'm not convinced that holding a
> "more relaxed protocol" event is a great idea.

Not to mention the fact that this would exclude everyone from parts of
the world that do not have a high vaccine coverage or a cosy "air
bridge" type relationship with the US (whatever that means); aren't we
supposed to be an international community? :/

-Toke

