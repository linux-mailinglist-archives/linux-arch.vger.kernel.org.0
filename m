Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051803A31C2
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFJRMY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhFJRMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 13:12:24 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6DAC061574;
        Thu, 10 Jun 2021 10:10:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so388765otu.6;
        Thu, 10 Jun 2021 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UEldWJV1cPWL8Nx8+B0VxRHw0WvFlQxd1i6CoueNSPg=;
        b=IRdg245kSIcipiUDAQsfeK8J7xCVSoOfZfPJ4r14rCu8g+/JY3t7WSjzmZpNfatzGA
         tdKtwOJKK7vj2sdT2/oC3mcL6UUy9itw++Knge0r2zC3GOdEwXz4tNJRExYZdxAmjxz7
         lYxBEsCby173q+VLTjhlgdy4pkqZ83fUBtrkwMGTPQGYizuQsYHUjRulz1WD1li99zaZ
         Cpw5NWZtPzRSAEiP4SSlWgE0/PRiOjHDFBEQtLCrIqCIVUgukQdXFkh15HYEUOfIqQo8
         nAlza83rQ5+c5oxa2W0soy2OALvCh3UobmoYd9YUiJ4zKpijb3qye6DaUV0fN51y7f74
         i3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UEldWJV1cPWL8Nx8+B0VxRHw0WvFlQxd1i6CoueNSPg=;
        b=PMqXlKUonycS/bDFeua3DjDojuOhCL0wceRTewEZ46RqbBr1J4Pd6R4whowYiW2lNr
         GxKT5rkC46ZU0tLhDmnGjr+h4Meypv0qEtXJT3TIgCxLSN2+2yC0j5/agDudRt17w33n
         AsVnELButY6602g+YGc4g1fxmFIv+hoAiBLpVQz03C2BEYa8YiWgoupBAOQN0M5oIotm
         TMxv+0km/1vUrlVdUm/Jyu8a1BXSRv3H7Hf3Cw5eaz2mzllONYq3AYCTEvnlmAuz+UkS
         O2rGifjrws5ov4d1UiK83JZOQB83brDBKPUO9moYJ9Qhh+4UWBzvajVK3nhHtD4vrRCg
         GOAA==
X-Gm-Message-State: AOAM5326rSrnje8mXnDO9WIAigt7U9fzESPr7W2znxhWrA6Yv3y29jOO
        OpqHsbyMLfcJEn3O7C1aa4U=
X-Google-Smtp-Source: ABdhPJxEihMj+amx9LkloPuUl4Htc/kRCs+S/cbsGvuN5hAZAo13Hhp/u6shvqBvrF3NMlAL7NQETQ==
X-Received: by 2002:a05:6830:2684:: with SMTP id l4mr3378035otu.294.1623345027254;
        Thu, 10 Jun 2021 10:10:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18sm706988otl.80.2021.06.10.10.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 10:10:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Jun 2021 10:10:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/3] riscv: Move kernel mapping outside of linear
 mapping
Message-ID: <20210610171025.GA3861769@roeck-us.net>
References: <mhng-90fff6bd-5a70-4927-98c1-a515a7448e71@palmerdabbelt-glaptop>
 <76353fc0-f734-db47-0d0c-f0f379763aa0@ghiti.fr>
 <a58c4616-572f-4a0b-2ce9-fd00735843be@ghiti.fr>
 <7b647da1-b3aa-287f-7ca8-3b44c5661cb8@ghiti.fr>
 <87fsxphdx0.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsxphdx0.fsf@igel.home>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 10, 2021 at 06:39:39PM +0200, Andreas Schwab wrote:
> On Apr 18 2021, Alex Ghiti wrote:
> 
> > To sum up, there are 3 patches that fix this series:
> >
> > https://patchwork.kernel.org/project/linux-riscv/patch/20210415110426.2238-1-alex@ghiti.fr/
> >
> > https://patchwork.kernel.org/project/linux-riscv/patch/20210417172159.32085-1-alex@ghiti.fr/
> >
> > https://patchwork.kernel.org/project/linux-riscv/patch/20210418112856.15078-1-alex@ghiti.fr/
> 
> Has this been fixed yet?  Booting is still broken here.
> 

In -next ? riscv32 doesn't even build for me there, and riscv64 images
generate warnings and/or don't boot (but that doesn't seem to be riscv
related, at least at first glance).

Guenter
