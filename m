Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2B7147153
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 20:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWTBa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 14:01:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42014 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 14:01:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so4524147qke.9;
        Thu, 23 Jan 2020 11:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=907wA0+8Q3SZ+tEArR2jGnLZ9RFPMcn5w1EEdI6pVwg=;
        b=VMqswA/J+7ATigs+BX5YY2AaOI0+cPO3PhE743H4ut0Gqt/By5PmEyiQ0qKySwgiqE
         4IHPXVIBGs7WQeFh/x96y8L40oGaCOyRPtetIxO/EqQB9g8/Y+oViaXcRtDbeO0gmyQH
         dfCGAR2EH1zNPeAXrJ3dZFQgzh2J8of6NSu8ewfFhgMvR3vb4v/3XxJFJB07KqFMNYJG
         tQjp6nKBXGmHw+ViSExfzQtzLLPaawGP7Fw0eq3SzgCWX55G0WTbknbFAjqcPVGZUPXY
         BTExC6t3qtigc5Wo4P6QByWBtKoSg5z7lKx+Pz5lRlMjG7FVxmRRQKiXr0wal+h0Hwyc
         eSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=907wA0+8Q3SZ+tEArR2jGnLZ9RFPMcn5w1EEdI6pVwg=;
        b=YIKJBMVWkkqVngpExggDIlX2koZja5x5jGM71fIA1zP4gdf0rYTHbIBpVwUsg+14JZ
         Nr3LYqdkb95ZN5dfVHlSsPE+MGBqYKc2OVF12y0IFCbp5XSeb7pdJILukVVFu/jhhzuA
         2/Kw+Vs5kXj6xxYnlOmekUo0Yss2bpCjjpUM93nrstsGIBFKbu8j8IdI5/akekEFTYUg
         kImwIecOrlMIQAU0WV9rvTNoJxs4L0jmBVElDh8DuretgFO/27zDQSzT5O/lISrak/gP
         CmkDqx7npLwJ7UotWdo8FENe1fNWjb1M//pneHD9MXZZstW48pEf0iHIdSsxyo48VnOv
         ImAw==
X-Gm-Message-State: APjAAAVciFrmI1vbOFDK7jpdxHHC1eU9edgFU7faoSNlCwqHIwwgJ07z
        BavK+5jeZ7Nzy8A9JXL+51c=
X-Google-Smtp-Source: APXvYqxBDzXGxI5Uk2o6AapNjbkG/L5A9z/XbTDtTRM/wNWF1dDd/6yZFcVvNQwRODcyrXaCkicBNA==
X-Received: by 2002:a05:620a:1666:: with SMTP id d6mr17824639qko.379.1579806089276;
        Thu, 23 Jan 2020 11:01:29 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x41sm1461080qtj.52.2020.01.23.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:01:29 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 23 Jan 2020 14:01:27 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Message-ID: <20200123190125.GA2683468@rani.riverdale.lan>
References: <20200123153341.19947-1-will@kernel.org>
 <26ad7a8a975c4e06b44a3184d7c86e5f@AcuMS.aculab.com>
 <20200123171641.GC20126@willie-the-truck>
 <2bfe2be6da484f15b0d229dd02d16ae6@AcuMS.aculab.com>
 <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkFGTeVQPm8Z3Y7mQ-=6d5CFxmEJ+hBb8ns2r2H1cb0hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 10:45:08AM -0800, Nick Desaulniers wrote:
> On Thu, Jan 23, 2020 at 9:32 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Will Deacon
> > > Sent: 23 January 2020 17:17
> > >
> > > I think it depends how much we care about those older compilers. My series
> > > first moves it to "Good luck mate, you're on your own" and then follows up
> 
> I wish the actual warning was worded that way. :P
> 
> > > with a "Let me take that off you it's sharp".
> 
> > Oh - and I need to find a newer compiler :-(
> 
> What distro are you using? Does it have a package for a newer
> compiler?  I'm honestly curious about what policies if any the kernel
> has for supporting developer's toolchains from their distributions.
> (ie. Arnd usually has pretty good stats what distro's use which
> version of GCC and are still supported; Do we strive to not break
> them? Is asking kernel devs to compile their own toolchain too much to
> ask?  Is it still if they're using really old distro's/toolchains that
> we don't want to support?  Do we survey kernel devs about what they're
> using?).  Apologies if this is already documented somewhere, but if
> not I'd eventually like to brainstorm and write it down somewhere in
> the tree.  Documentation/process/changes.rst doesn't really answer the
> above questions, I think.
> 
> -- 
> Thanks,
> ~Nick Desaulniers

Reposting Arnd's link
https://www.spinics.net/lists/linux-kbuild/msg23648.html

Seems like there is nothing still on versions between 4.6 and 4.8. It
might be useful to put a list of distro's that are running the current
minimum supported toolchain versions in process/changes.rst?

I think the issue is not just kernel devs. Users may need to compile a
custom kernel or at least build a module.
