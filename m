Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F283E0976
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 22:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhHDUkb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhHDUka (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 16:40:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971EFC0613D5
        for <linux-arch@vger.kernel.org>; Wed,  4 Aug 2021 13:40:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so1676126pjn.4
        for <linux-arch@vger.kernel.org>; Wed, 04 Aug 2021 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dit+/Sp1lC6totPcj+YpQn69uliJHNZ4tY9ArlksPHo=;
        b=TyhICT6tJ0ec1RQ9pgr0YmqC90JE7hdXdP9UHrKdA7/bYeqUiHI+/nBKIv/P4hiOw+
         e/Yv7wWWzyvnpq21xxdocilZp1rd8PFDdUuAP4+tOm45At8VQXSL9nMgJ+fEe1uuLlDb
         lExEJV936MlFwfML+b9yOzDzNo075cp1cjL3CsLlyTAk4hjENo2fCoHh8pnhn3GkRWyt
         0+taDDBsLRajHbuYiY6LbKPw2+6/KZ7q/5R1TpIMEtP7ZFK/ov9y0fk89ftNF/aXQwXD
         zh/LtCSF+KdYyVSdQE7yfEZUKZMt0CuZe+qQC9ZCX2h6evLEU05WEnfrOVgtXYGmnzH/
         JL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dit+/Sp1lC6totPcj+YpQn69uliJHNZ4tY9ArlksPHo=;
        b=MkKeK7xi5xGZwDj1hoqXybCAh/nO1q9GzTajRdLuqKz+GsCo5RAfTebL8OCKhlg5vT
         6OqC9fVBTEj2yySilP5riF+QjXcmgzMww77T4faqYwKXmkiziedqV8jvjJjnI4gIijkW
         Ghs9sGoaGMaodm6g0ZzBJK1U1S3G/iwoMBqd9lMX90h++nvqZg71egZqr8GDf8e7iQVZ
         MdCvFhFGB/1c1m0gpEBujaAezi/INNSLlfobAXBfGqXQDLzCQWdPCL3PQDTHxF6vSQyK
         5l9uogxc9F857DFwSX5tyaRjFoQQUA9boIN0wB7XnKuzUaTlF4nqdrp15avI/IDFxHbb
         Pj+A==
X-Gm-Message-State: AOAM533dvMiudxD7HJxDflxddMu0JBt9yL8v7MgXhf1nN/iNOuMEBDxj
        167SDuaJwGrA2y3zP29wtPpN7w==
X-Google-Smtp-Source: ABdhPJwnTJVkLHdHiuNAm+IAtSRcOGH2SY6t5oaxIRPc4QRcH3junRf7HX4/2yey0W5WRXV6OeJy9g==
X-Received: by 2002:a17:90a:df05:: with SMTP id gp5mr916796pjb.165.1628109617098;
        Wed, 04 Aug 2021 13:40:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ms8sm7067173pjb.36.2021.08.04.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 13:40:16 -0700 (PDT)
Date:   Wed, 04 Aug 2021 13:40:16 -0700 (PDT)
X-Google-Original-Date: Wed, 04 Aug 2021 13:40:14 PDT (-0700)
Subject:     Re: [PATCH] riscv: use the generic string routines
In-Reply-To: <CAFnufp1QpMc87+-hwPa887iQQGCjjkGNanVSKOUsE-0ti82jrA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        kernel@esmil.dk, akira.tsukamoto@gmail.com, drew@beagleboard.org,
        bmeng.cn@gmail.com, David.Laight@aculab.com, guoren@kernel.org,
        Christoph Hellwig <hch@infradead.org>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mcroce@linux.microsoft.com, mcroce@linux.microsoft.com
Message-ID: <mhng-7b8d3a12-e223-4b69-a35a-617b0d7ac8f7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 03 Aug 2021 09:54:34 PDT (-0700), mcroce@linux.microsoft.com wrote:
> On Mon, Jul 19, 2021 at 1:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>>
>> From: Matteo Croce <mcroce@microsoft.com>
>>
>> Use the generic routines which handle alignment properly.
>>
>> These are the performances measured on a BeagleV machine for a
>> 32 mbyte buffer:
>>
>> memcpy:
>> original aligned:        75 Mb/s
>> original unaligned:      75 Mb/s
>> new aligned:            114 Mb/s
>> new unaligned:          107 Mb/s
>>
>> memset:
>> original aligned:       140 Mb/s
>> original unaligned:     140 Mb/s
>> new aligned:            241 Mb/s
>> new unaligned:          241 Mb/s
>>
>> TCP throughput with iperf3 gives a similar improvement as well.
>>
>> This is the binary size increase according to bloat-o-meter:
>>
>> add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
>> Function                                     old     new   delta
>> memcpy                                        36     324    +288
>> memset                                        32     148    +116
>> strlcpy                                      116     132     +16
>> strscpy_pad                                   84      96     +12
>> strlcat                                      176     164     -12
>> memmove                                       76      52     -24
>> Total: Before=1225371, After=1225767, chg +0.03%
>>
>> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> ---
>
> Hi,
>
> can someone have a look at this change and share opinions?

This LGTM.  How are the generic string routines landing?  I'm happy to 
take this into my for-next, but IIUC we need the optimized generic 
versions first so we don't have a performance regression falling back to 
the trivial ones for a bit.  Is there a shared tag I can pull in?
