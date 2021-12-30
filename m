Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F942481E0A
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbhL3QT0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Dec 2021 11:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbhL3QT0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2021 11:19:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19865C06173E;
        Thu, 30 Dec 2021 08:19:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6743061700;
        Thu, 30 Dec 2021 16:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C891DC36AEF;
        Thu, 30 Dec 2021 16:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640881164;
        bh=arlWW/UtCGQmMH5E2Pogag5ZNNfDUyUhSMYEtoB3GwU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nallgZfdxZjoVCuHYZ4XlZvCFvFjCagAjfY/7DnXl6uLT3rQXZhTqfX8CxA2KfD5s
         ggMTdGtk4qkhT64rRpeqYTGP0AX7rd5U9SpMvtI5EA3ixEunFcmItWDP+Dny71TOkU
         2N+6dF/itqqOSChjsVTnbC/RnZjqsumYlT6QDIepmBYHjzM3WHIoXjPTsXx998T4MH
         AbHzEa9iCb3R8ZQuSPQxkbKl22DO8o6HOrukaINf9SUG+j2QRXNBifWfkcqIVJpn3F
         2oqxztcYkbMDMWDWXHLWL9/qwAxBjNURJG+yFFF4BLBbRogQN0MJupw1+goKz9KbcM
         BfBhOeAdyvsxQ==
Received: by mail-wr1-f52.google.com with SMTP id d9so51458108wrb.0;
        Thu, 30 Dec 2021 08:19:24 -0800 (PST)
X-Gm-Message-State: AOAM532osZQpPnndUEtZIgzOHkp5U++kfLnr7S6WN14jxOZUNNgk0gXd
        6EjB9ZFeEYfDz+9kg/nTx6c548y3b0UM/JrdXSE=
X-Google-Smtp-Source: ABdhPJzh0JRUZ8uDOReUUyLcA2Hj2LVO0R3PZ4wX3Eigt9m04vC/yXSrbqUBq3MAhxfR6QKgikfyV3h0Maj9zD2gdAs=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr25095895wru.12.1640881163018;
 Thu, 30 Dec 2021 08:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-31-schnelle@linux.ibm.com> <YcrIHxTDipVNUuCA@kroah.com>
 <b9d0c0b88ef66f9beb51a880e765177670a76394.camel@linux.ibm.com> <Ycw6kXhd+NV0GMWc@kroah.com>
In-Reply-To: <Ycw6kXhd+NV0GMWc@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 30 Dec 2021 11:19:05 -0500
X-Gmail-Original-Message-ID: <CAK8P3a1p6_=s4XcJiJSkuZJBrCpwCXQ1MX6EadY00KdypVQisg@mail.gmail.com>
Message-ID: <CAK8P3a1p6_=s4XcJiJSkuZJBrCpwCXQ1MX6EadY00KdypVQisg@mail.gmail.com>
Subject: Re: [RFC 30/32] /dev/port: don't compile file operations without CONFIG_DEVPORT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 29, 2021 at 5:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > > > -static const struct file_operations __maybe_unused port_fops = {
> > > > +#ifdef CONFIG_DEVPORT
> > > > +static const struct file_operations port_fops = {
> > > >   .llseek         = memory_lseek,
> > > >   .read           = read_port,
> > > >   .write          = write_port,
> > > >   .open           = open_port,
> > > >  };
> > > > +#endif
> > >
> > > Why is this #ifdef needed if it is already __maybe_unused?
> >
> > Because read_port() calls inb() and write_port() calls outb() they
> > wouldn't compile once these are no longer defined. Then however the
> > read_port/write_port symbols in the struct initialization above
> > couldn't be resolved.
> >
> > >
> > > In looking closer, this change could be taken now as the use of this
> > > variable already is behind this same #ifdef statement, right?
> >
> > Yes
>
> Great, feel free to send this individually, not as a RFC patch, and I
> will be glad to queue it up.

I think this patch should contain the 'depends on HAS_IOPORT' that
is currently added in a different patch (char: impi, tpm: depend on
HAS_IOPORT).

However, we can't merge that version until HAS_IOPORT is actually
added to the kernel.

      Arnd
