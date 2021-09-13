Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850F6409798
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbhIMPlm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhIMPlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2021 11:41:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D0C0258D6;
        Mon, 13 Sep 2021 07:58:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c10so10766680qko.11;
        Mon, 13 Sep 2021 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFD9mJaBzJKTsxm4rXZDM/y2enE6R8R76CfOiZbw4HU=;
        b=qnKybz0B5oVmKPyqgPGoezg+mvumei8Ol/qbWrUBL+z62ewI9zUSkCFC3ftaPqEqcc
         gLXcRv87aSGCie0vaSkzGAl3kQXgkC4/cMVUpMQKuDFKsBoAS1IHqTdxQysnbdczJOs9
         Pu4STzHY57inMcRXJrQE9hKsnpZnUcw1041ZMn2SnOmiKaSW4im8jgqnPDHDkRaS2hMO
         FCbdndbc1iePtXhGd4fN5oN1itGrF+DfjK1T8umBrN34OGUzoiXQwF4C2w00P084yeq2
         OrUAHxHaX2SdmfZ1QcojHh7rP7jANKFxLBSi96UHn/K2atcNAZ+bcklkrFxEjvEReeXV
         MQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFD9mJaBzJKTsxm4rXZDM/y2enE6R8R76CfOiZbw4HU=;
        b=dRiqZO1h6Xn9sSBP1ewOghEj5BnEMyRuBLkJVpYoUuXgXRzIFpVxY8z6lvIOpi+Aoz
         yGa85U7oZfF0a+mdpg0Nhe0hdPbdVcMrmMZITLJSJJj4yn6lkaQgjTHl7WRJETwO0QXq
         eKxLNDQ5xeQ4lZvs/yqHY58eUFfGKZ9uEuYRGSuGKn9HYnt8awaey6vBhe6a2crUAIzk
         2/RlhNmwTqahZkF+UH7W7nEM5ckvvze+MRg0jVVv4M/TCvAUsyko1KD3cQzgsx1ZUhyU
         gTOqeTtdgxv8mXauzlNV5WNihZVOZTyjCfzTiPU9n3ra1wNPCiUjzl8k4lC3AcifcM54
         0e6w==
X-Gm-Message-State: AOAM530WiDdXFDwMoCkgOkFxIWQ2zOTcFSQy8j6YTmfiSH+vRmkGBmvY
        XOoUuHiE3A9A+qlJowPflrSd5sjRwce0Ego4Kwc=
X-Google-Smtp-Source: ABdhPJwh26MSRjVjkR7VkLGGkQY2c6BDDe1IfCUBySjVHMeGamtvhofk0Vh4g8ftw3wylX8g4u0wJNN4bwP+UgU/wSA=
X-Received: by 2002:a05:620a:254d:: with SMTP id s13mr16048qko.264.1631545111542;
 Mon, 13 Sep 2021 07:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210910141940.2598035-1-schnelle@linux.ibm.com>
 <20210910141940.2598035-2-schnelle@linux.ibm.com> <87wnnnl67a.fsf@mpe.ellerman.id.au>
In-Reply-To: <87wnnnl67a.fsf@mpe.ellerman.id.au>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 14 Sep 2021 00:58:20 +1000
Message-ID: <CAOSf1CEQB_Fz_yF0pgs6xqJJ2Say1a2XFjOedO2mE=Qn_BgbnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc: Drop superfluous pci_dev_is_added() calls
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 11, 2021 at 9:09 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Niklas Schnelle <schnelle@linux.ibm.com> writes:
> > On powerpc, pci_dev_is_added() is called as part of SR-IOV fixups
> > that are done under pcibios_add_device() which in turn is only called in
> > pci_device_add() whih is called when a PCI device is scanned.
>
> Thanks for cleaning this up for us.
>
> > Now pci_dev_assign_added() is called in pci_bus_add_device() which is
> > only called after scanning the device. Thus pci_dev_is_added() is always
> > false and can be dropped.
>
> My only query is whether we can pin down when that changed.
>
> Oliver said:
>
>   The use of pci_dev_is_added() in arch/powerpc was because in the past
>   pci_bus_add_device() could be called before pci_device_add(). That was
>   fixed a while ago so It should be safe to remove those calls now.
>
> I trawled back through the history a bit but I can't remember/find which
> commit changed that, Oliver can you remember?

Yeah, on closer inspection that never happened. The re-ordering I was
thinking of was when the boot-time BAR assignments were moved in
3f068aae7a95 so they'd always occur before pci_bus_add_device() was
called. I think I got that change mixed up with commit 30d87ef8b38d
("powerpc/pci: Fix pcibios_setup_device() ordering") which moved some
of what what pcibios_device_add() did into pcibios_bus_add_device() to
harmonise the hot and coldplug paths.

As far as I can tell the pci_dev_is_added() check has been pointless
since the code was added in 6e628c7d33d9 ("powerpc/powernv: Reserve
additional space for IOV BAR according to the number of total_pe").
Even back then pci_device_add() was called first in both the normal
and OF based PCI probing paths so there's no circumstance where that
code would see the added flag set.

That patch was part of the PowerNV SRIOV support series which went
through quite a few iterations. My best guess is that check might have
been needed in an earlier version and was just carried forward until
it got merged. I didn't dig too deeply into the history though.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
