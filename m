Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873B2F1039
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2019 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfKFH3S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Nov 2019 02:29:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37563 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbfKFH3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Nov 2019 02:29:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id p24so11675305pfn.4;
        Tue, 05 Nov 2019 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CZXGdk9uFu2d7V8fak5kkfAh72DjR9+d3K1XsYdLz38=;
        b=oGcJVGIO9nAfwZ9U9gs9P3ysGflXOrasF6qEiEhb6WpEy/r0O4b4WcXcLFHBABCJ7R
         QUOnBvxM0K+ORQ5GEwdd68Rbvuyj5JajApo+O20Qk7aw+1UO9FWS+6+LzSfRmtqSLrdq
         xvCHWuUmC+aEABOOmXkQjFb1AvmC1AZ+Bwjcb+sSQtS1GRTuQLMEbpuch+Wd9OB5B9nR
         MEP3ZWqL3l8J6HAnG5DRusZtOBOPsYcpMAZ4FMs88UBSyQ00BeMuWCLwvOdu7PSHWk++
         XtgmclZQxAc89Qmj6l/gKcwAVt76pZv/YKMWttV48g2arcZGneYo8SkwGAFkxvqsnIJf
         JInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CZXGdk9uFu2d7V8fak5kkfAh72DjR9+d3K1XsYdLz38=;
        b=Q4lV1Xswzj4qqatwb2ujC9gH4pkWhafFPB07X3XWK5E4TIvxWZf5BonxcBXijR+sP3
         KO7Jawtje/RgwKtFxzHCm/bUSdoEMzjUIedL1L0PziiLoe9Y5lVRb1/B5zuqH+Tk5TuK
         ZvtMULnCb9GaFGUQYrXl5lNqDotlk4LwdnAd4S912B99Y5r/RY8FwSw4p9sNHIrwjw4f
         GtipFVCOqm4/Npf3aGZqvb5CK2Y8G7n2OCX2yDErC+b722KDa0HWxcEqz/tMdNWeWnmT
         3qnKNu+i+IA5jBxR1KyKPpV5G9CoTYdTyP0kAqylNa1fhiIqJbFWFOC/hS4JNyiOyFu4
         c90w==
X-Gm-Message-State: APjAAAWRqo10a89mb3Iuje+7KWXGLTsaLpeuTAj21ItbCJq+/93JjN+v
        YDUbWDkzAVXGLLdoxi44CR0=
X-Google-Smtp-Source: APXvYqxBVXh1jmjAePr3S1g4NtkWBhTLAIl9OTaZqYXb6wMgMaiO3o4Y3mgSEbDLjoLjMA38tOeOfg==
X-Received: by 2002:a62:90:: with SMTP id 138mr1557534pfa.209.1573025356612;
        Tue, 05 Nov 2019 23:29:16 -0800 (PST)
Received: from [192.168.1.101] (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id h13sm26505185pfr.98.2019.11.05.23.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 23:29:15 -0800 (PST)
Subject: Re: [PATCH v3 05/13] m68k: mm: use pgtable-nopXd instead of
 4level-fixup
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>
References: <1572850587-20314-1-git-send-email-rppt@kernel.org>
 <1572850587-20314-6-git-send-email-rppt@kernel.org>
 <CAMuHMdUG3V7uxzhbetw75vVeobeP0-bQySb3r=0V5XujUF123g@mail.gmail.com>
 <20191104094748.GB23288@rapoport-lnx>
 <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>, Peter Rosin <peda@axentia.se>,
        Richard Weinberger <richard@nod.at>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-um@lists.infradead.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <15fafca0-e4c4-1f46-4f19-9b2a177f7d6b@gmail.com>
Date:   Wed, 6 Nov 2019 20:28:59 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVHsNyLxhaxZcVdLvQ1PUnb=2_+ECPWVD0234V+qu+kOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

Am 04.11.2019 um 22:53 schrieb Geert Uytterhoeven:
>>> This indeed boots fine on ARAnyM, which emulates on 68040.
>>> It would be good to have some boot testing on '020/030, too.
>>
>> To be honest, I have no idea how to to that :)
>
> Sure. This was more a request for the fellow m68k users.

I heard you :-) Still doing more regression testing on the latest SCSI 
fix, but I can schedule this next.

Cheers,

	Michael

> But don't worry too much about it.  If it breaks '020/'030, we can fix
> that later.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
