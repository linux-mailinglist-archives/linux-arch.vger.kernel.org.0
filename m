Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE44580677
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jul 2022 23:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiGYVZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jul 2022 17:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGYVZq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jul 2022 17:25:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C3622BFB;
        Mon, 25 Jul 2022 14:25:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y141so11520222pfb.7;
        Mon, 25 Jul 2022 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRdczfwqTE1ClSc+nVMd7FDIiV42abVCNkRv2IL8Lek=;
        b=L6AKMM6K4trb2vONHbs3hxILEtF+2UgNvTe16SDRmYlKVhAG67nRJYhPOPNlejNU9k
         e3pqftybhinP1UmAAjwe4lAvrRhqOOlTYhZZDByfIDWIL5QunSTgfqoZZnBmIN5Uikdn
         RPB0p2npCp0f2lnS31YBgavWOG3ReU2zxNJ1DX8upUd7GWJBCbqfL/fZGabxJNwQWIZ3
         pvDbMfIp07dcp0vFPjTGQk8oKTyb2WhYwpNbIixgYAyaDtF14E3MyxbjNevn1qD4azBu
         EsG/W7w4mHpxY6csvkkBX1FMHozd2JAkh1IpTJLXnYEmQOo3qhIuHpNaBWSxaOG/hibm
         5xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRdczfwqTE1ClSc+nVMd7FDIiV42abVCNkRv2IL8Lek=;
        b=VL35w5fdnGMuY3iG2s443uEiyKVFSQ5qYxErsMgrY9RXVoNhhHH+a5zxglmwE9nKr8
         WlfSsM+Y19Zn8YFWcvkrO/lCBVrA3CYnf0OPAKkYGg5uR6I3vmZ5fg66KBZKy5zl+9N/
         7bshkr43RENpyXuTLNCJwyv8mCCPPug6P2oFmwmGiGB2KqeVN4sBkFIqpq1U9zJHpZx7
         bn8RbLANjvrh1C03Xj5pgRaRLqcXItZocauJyObVh9n3iOpGXmCxT4Re8AIRo1njilZU
         YfzssKWeoCUqaFCP/XkIyMpZTZyYL4rpdcR/ry6lnMWrPgKTboCMsSwKZ9kw2Q1PP20B
         X0NA==
X-Gm-Message-State: AJIora81vgoiYge1s+gUUfSgDG1Nv83WjOXD9PtvbSIMW+O1GjtGPmEY
        Ll4CpV8SLF/oBnPBHdlw8Q0LuKUG7qcQRg==
X-Google-Smtp-Source: AGRyM1sd1c1I+EYc9ZvSrnDP1TC7QERjPcDblbVBFnbkdez9paKN37PMRziYxYw3G13XnAyGRU2PGg==
X-Received: by 2002:a63:d711:0:b0:415:c581:2aff with SMTP id d17-20020a63d711000000b00415c5812affmr12701105pgg.278.1658784344817;
        Mon, 25 Jul 2022 14:25:44 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b0016c3b0042d0sm9735220plh.14.2022.07.25.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:25:43 -0700 (PDT)
Date:   Tue, 26 Jul 2022 06:25:42 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/3] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Message-ID: <Yt8KVnwgzHFZbtQv@antec>
References: <20220725020737.1221739-2-shorne@gmail.com>
 <20220725171059.GA5779@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725171059.GA5779@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 25, 2022 at 12:10:59PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 25, 2022 at 11:07:35AM +0900, Stafford Horne wrote:
> > When building OpenRISC PCI which has no ioport_map we get the following build
> > error.
> > 
> >     lib/pci_iomap.c: In function 'pci_iomap_range':
> >       CC      drivers/i2c/i2c-core-base.o
> >     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
> >        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
> >           |                                         ^~~~~~~~~~
> >     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
> >        44 |                 return __pci_ioport_map(dev, start, len);
> >           |                        ^~~~~~~~~~~~~~~~
> > 
> > This patch adds a NULL definition of __pci_ioport_map for architetures
> > which do not support ioport_map.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> FWIW,
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thank you,

> I assume this will go via some other tree; let me know if otherwise.

Yes I plan to send this along with the other patches via the OpenRISC tree.

-Stafford
