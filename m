Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6BA148CDC
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgAXRU0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jan 2020 12:20:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39631 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbgAXRU0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 12:20:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id 4so1445829pgd.6
        for <linux-arch@vger.kernel.org>; Fri, 24 Jan 2020 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bs90XjUYMO1YPG7bJhgYggIHQGa3xCMAwvskxDOh3k=;
        b=a4dVXxPuiruxw8rtFKoZ6kNGVafNrVqCDVUh1UJ1FoRsnV+PG4E0bhfBBpHRaoSonQ
         YaZB3M2bC2FY582MMMref3d3YaYxNd3pp0uYPOUsF7b577uC7nTSX4UMKlkrLR+rucPm
         Z8hSY2J2ao1kz2eoCsXaw5ersUa6NnnQbMt8vX1kbBaSzCWJoO9na6YNogES4989qy+1
         CrFjGBEkkkgHi9bTCsWDRhnFPO9EDSmMcu9m7Dvxm1GBj3E7H6Imv/pL2GSPgeziqe8l
         f8+yOk+9oNubYAbSOGdQ/ZGnsh459B0gxgIQlWgPd0aUJ3vukEFvRiKEskT7Q5RLtTGX
         5akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bs90XjUYMO1YPG7bJhgYggIHQGa3xCMAwvskxDOh3k=;
        b=L4gCO/pXRrqzrNPgllf94Uf2E8aIwdylfANx8eI821+mE1bE3oiiQYwq5bavtNoB8W
         NsCTEStljubfZukD2kjAE41Y5L9Vh0ekc83KeFD9s3LdNHYyfxUvqv06wWK6GMbHyYIX
         Eh0I+zantVX+6X3EIpcmxJ8OeEo7vokrCPfi1IMCZtDCdsI1q5PRT38suabRLtEQvj+/
         Jto/mKhSjvjSSbhIFWZdNrtmILhetPW9ixKnREqIDQaJp7vJPNgEHt39fI2YEekEMW1w
         Z08b45MYR3jvDoOTOuFx3lxySihqb9fDHbx9mDjaS5+urwBND1U1deeqI/GA1r5MoAPw
         31ag==
X-Gm-Message-State: APjAAAXtFMPICWDgz4LyfFDb8eXFMKn8Rse1kD3fI+dAs427ajmb8zjl
        Gbxf+s3FAOupm+lBdzn971/3MWTjFyM7eVwAmB69tw==
X-Google-Smtp-Source: APXvYqyPC1tuztho8bkaXOVF7RDbM0R+AbuQOx09meijPzDaIhSpkrDwTE+Ulpx+9k7fdY23v3w7uXyyKDv7Ew3hXkM=
X-Received: by 2002:a62:e215:: with SMTP id a21mr4264005pfi.3.1579886425680;
 Fri, 24 Jan 2020 09:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 24 Jan 2020 09:20:14 -0800
Message-ID: <CAKwvOdmTOoTXCGN9NaO5_+sqDsK364=oCiVO_D5=btj1GsJrnw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 24, 2020 at 12:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 11:07:59AM -0800, Nick Desaulniers wrote:
>
> > Good thing it's the variable being modified was not declared const; I
> > get spooked when I see -Wdiscarded-qualifiers because of Section
> > 6.7.3.6 of the ISO C11 draft spec:
> >
> > ```
> > If an attempt is made to modify an object defined with a
> > const-qualified type through use
> > of an lvalue with non-const-qualified type, the behavior is undefined.
> > If an attempt is
> > made to refer to an object defined with a volatile-qualified type
> > through use of an lvalue
> > with non-volatile-qualified type, the behavior is undefined.133)
> >
> > 133) This applies to those objects that behave as if they were defined
> > with qualified types, even if they are
> > never actually defined as objects in the program (such as an object at
> > a memory-mapped input/output
> > address).
> > ```
> >
> > Which is about the modification of a const-declared variable (explicit
> > UB which Clang actively exploits),
>
> Just for curiosity's sake. What does clang actually do in that case?
>

https://bugs.llvm.org/show_bug.cgi?id=42763
I was playing around with this in godbolt but couldn't quickly come up
with a simple reproducer.  IIRC, I've fixed maybe 3 instances of this
recently in code though.
-- 
Thanks,
~Nick Desaulniers
