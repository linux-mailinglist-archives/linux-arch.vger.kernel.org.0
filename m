Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0713F5553
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 03:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhHXBGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Aug 2021 21:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhHXBGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Aug 2021 21:06:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96618C061796
        for <linux-arch@vger.kernel.org>; Mon, 23 Aug 2021 18:04:11 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q68so1166031pga.9
        for <linux-arch@vger.kernel.org>; Mon, 23 Aug 2021 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
        b=ssDUJbZQUoHOjzKeOoupouQflaDtoV/KGM0ZbImx65Id9YAIXzBr7xLGKgTJu5h7I2
         HHPWAyYNY1bDMlXgvnD4vDkqa1dsykDsMeTtzg3vHCZHA743vpTJ8zJ4NdfqSdbmmqvy
         KiEWa7Khi9N0O/9RoziHtutYHO2/nwyh6DBm4tBUK7GNpef0LXqDL+0p5s3nrsgMW6K/
         FFWm8o5SonyxAvLyA2+U5fUS7ZWjvbxn5iMEzqko5Bo0H+b6KX6dRPsNpkxsT+0zJzz9
         wV+DeBmwuvYfrQWDLM0QASdRWxoXpFfTwLTHLiDMsXuWjkskMss7fMermWEKgv/FmCUr
         IxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KWjXh2lT4oyxvT6TUUge6cE2M/3E1/QPatrdIWAbCk=;
        b=Bd+GZcagInPCelLBf0Ddz83gFUheM1k430zVQpisa6z1qNKmu6VRvzzNYcyszyc0bV
         G0EIBkjazVQzgNCCPuD1IxVhnNKyoSIm/uQcn26GDM47Z8JdF35qLHXKviz5mhYMGF3T
         8qlCOy9P0zOtn84g/nLYB/P8NwvhrVCnCEIhsYGoOkkWb/bgQGW0QmVhhQIDALv6a/th
         OzYq0bJE4gdR071FiR1Is2+y+7siuoX+yRqRCEU2KzmLl/JinoFSxjvcBEFjPJczlHE1
         DkJHA9Q2mVXdqaAzpKgaQXmrbVaSBOYWARKqNJq0/jKEr+jXAGrEJzQfwXubkupGTifM
         FGNA==
X-Gm-Message-State: AOAM531+7UEOfhLq/cGP7GAmmQUB2cBNms0lmZi0Y2bhoCW3bScLkl71
        GQyLSApyqz8e2XntLYsZr5iUKl0GppAEzXVLUF6vbg==
X-Google-Smtp-Source: ABdhPJwr+d+03lWZE5hBC3RKJQrz+BrvZKJ9PwHrCLpkrlXplyqx0kAfavOgC5QFY0A8k9yCeP+k8gHn1t12t0fKZcY=
X-Received: by 2002:a05:6a00:16c6:b029:32d:e190:9dd0 with SMTP id
 l6-20020a056a0016c6b029032de1909dd0mr36118105pfc.70.1629767051049; Mon, 23
 Aug 2021 18:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org> <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
In-Reply-To: <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 18:04:00 -0700
Message-ID: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 23, 2021 at 5:31 PM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> >> Add a new variant of pci_iomap for mapping all PCI resources
> >> of a devices as shared memory with a hypervisor in a confidential
> >> guest.
> >>
> >> Signed-off-by: Andi Kleen<ak@linux.intel.com>
> >> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > I'm a bit puzzled by this part. So why should the guest*not*  map
> > pci memory as shared? And if the answer is never (as it seems to be)
> > then why not just make regular pci_iomap DTRT?
>
> It is in the context of confidential guest (where VMM is un-trusted). So
> we don't want to make all PCI resource as shared. It should be allowed
> only for hardened drivers/devices.

That's confusing, isn't device authorization what keeps unaudited
drivers from loading against untrusted devices? I'm feeling like
Michael that this should be a detail that drivers need not care about
explicitly, in which case it does not need to be exported because the
detail can be buried in lower levels.

Note, I specifically said "unaudited", not "hardened" because as Greg
mentioned the kernel must trust drivers, its devices that may not be
trusted.
