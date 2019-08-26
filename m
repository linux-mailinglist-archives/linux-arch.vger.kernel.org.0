Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA09D905
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfHZWZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 18:25:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44629 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfHZWZX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 18:25:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so12690421pfc.11;
        Mon, 26 Aug 2019 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdrKt952AuvDe+QMynjr4iuarcTkuNP/kAs8J0u4A+s=;
        b=a0zMmyWBK90UYJtyoqynyxpcCWQ63iFelFOAu2wf9q+P7tEGrAMDTLQ7ns9kTHCAvV
         zOtTYGjAxNvaMG4PH070aBsaBC17H9ftkGmoEi1jbpZFGywLt3QZL7gqqDvhtYn2QJAj
         HSQU1nyy/xAx7EGwqSnb5+oUhOiY0vilM355IeRksUhMIXlBU+ac4G4LkEY6hh/lQJqH
         TCnArxvquzzcbANPftPtDewlrkSUrPpD/afdr91bwf897Kd0DnHeETaJ3blnDHKXuHRK
         pv4PbuZrnheVZVo5X1lDBWaTzlVchp+wBfR+mBKzN+vI9AKQDusQD89Py284sXkk9381
         0sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdrKt952AuvDe+QMynjr4iuarcTkuNP/kAs8J0u4A+s=;
        b=KSHgrX/UBpJ7cZ/sFyq+9sMpkO0OYdJBG82YELef6tgxK971HNFxg9RdsBBZEIZtmK
         G0msadhnwSVWFZPpuZCYpV25ff3JyzIsFCdPn4Wl1AqGB1NIUIvUu9vEQK7obSX5+qHG
         DqCIQdreu6j1XjbGEI8c5FGXqjXpQgzHl7W4vCbjM8bhBYneb4jP/ps99boZvkNU6/0z
         dqJuC6mZx8oSQM+1Jh71K3oVueJVhSBC9SHSMMSg19PH4ClTUAPj40zGNsH1S9yLG3xX
         lDI9JqbU6M3UA2uYesn36PoTdeDW6kNOtVvsRGC0pLZe9Tgg37PNTYKYgGu8VG/+XmoI
         FXYw==
X-Gm-Message-State: APjAAAWKWq5Xa2veqx3GYwhyT2qQm8vWgj1yNQdOMYLGnRYtB4ppO5/S
        PCwJf0aLxX74xQJY5XBpqn4=
X-Google-Smtp-Source: APXvYqy681ZUL1/GOI1ZqNuttC4tPBoxw38R2Hiki+GEnFDGGEOPoegEj5VFS0OPFx5JUD/3pSIIpA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr8200381pgu.289.1566858322037;
        Mon, 26 Aug 2019 15:25:22 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t6sm449041pjy.18.2019.08.26.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:25:21 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:25:12 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 03/11] asm-generic: add generic dwarf definition
Message-ID: <20190826222510.6m2k3puwflnr52b7@mail.google.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-4-changbin.du@gmail.com>
 <20190826074215.GL2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826074215.GL2369@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter,

On Mon, Aug 26, 2019 at 09:42:15AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 25, 2019 at 09:23:22PM +0800, Changbin Du wrote:
> > Add generic DWARF constant definitions. We will use it later.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  include/asm-generic/dwarf.h | 199 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 199 insertions(+)
> >  create mode 100644 include/asm-generic/dwarf.h
> > 
> > diff --git a/include/asm-generic/dwarf.h b/include/asm-generic/dwarf.h
> > new file mode 100644
> > index 000000000000..c705633c2a8f
> > --- /dev/null
> > +++ b/include/asm-generic/dwarf.h
> > @@ -0,0 +1,199 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Architecture independent definitions of DWARF.
> > + *
> > + * Copyright (C) 2019 Changbin Du <changbin.du@gmail.com>
> 
> You're claiming copyright on dwarf definitions? ;-)
> 
> I'm thinking only Oracle was daft enough to think stuff like that was
> copyrightable.
> 
ok, let me remove copyright line. I think SPDX claim is okay, right?

> Also; I think it would be very good to not use/depend on DWARF for this.
>
It only includes the DWARF expersion opcodes, not all of dwarf stuffs.

> You really don't need all of DWARF; I'm thikning you only need a few
> types; for location we already have regs_get_kernel_argument() which
> has all the logic to find the n-th argument.
> 
regs_get_kernel_argument() can handle most cases, but if the size of one paramater
exceeds 64bit (it is rare in kernel), we must recalculate the locations. So I think
dwarf location descriptor is the most accurate one.

-- 
Cheers,
Changbin Du
