Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275AE484B25
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 00:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiADX1n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 18:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiADX1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 18:27:42 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE90C061761;
        Tue,  4 Jan 2022 15:27:42 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j6so154479264edw.12;
        Tue, 04 Jan 2022 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Cv5WeOv7Tkjfvs0p7bNFLZQbOHjCEbvTG2WwZ+PJtE=;
        b=PZHDaNYG74eVQ9et4VXd8d/3UwzfH8cmtITrfpQmpyDu6Goc4ENYNhH0DUtd4/67WX
         2jsEEEPKqh3jF0E/0Nrkek3i75ca7Q3PpOIVlbA5bvoUBmMu7lmnDNulJT4y4JhAQbjj
         gutduxC+9yRGxHCoRpiIfsCFRxHa+9rOPas/JsHulNW1ivo1bps+H2Mmfe4NG7OEcrud
         FCbP0mbdyXcRr7lZDJEhdVhJeL42B7jgAdot3UYgghV8YHYof4YmvffRozcp/o+ILm9o
         0VMZSj5hy25IknttuNbhM8BcWtMLPyBgMGyVQ2UQFAne4tEbgdfMvTbdfWaVVaxKgIGJ
         tMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2Cv5WeOv7Tkjfvs0p7bNFLZQbOHjCEbvTG2WwZ+PJtE=;
        b=4lYjegzwdQb/gXYb1ZXQ8zqp6syvhFBoT9+uJjDMs6DCsoFDs9eMg2xBAXfB2/NLdn
         Ex3dSUbkqrHBT1gQ5VB2uCaQy/KzLmPx03+h1drrYni/3ehWBuaOgOGoNR4coihV1ZM/
         00AavYa+Q8qeQigFdtVNaXxbEeo4cAelL4cD0Pnpth4xC1qvWvYKfF3gnow69KP80sIN
         iKBWRbgKHgi3aEbYBluCtKDsjNTedzxXL91H4rIgdoX68cPGGMwgf8euI3GAar/z+3x8
         TtbnOt3qFQBiqH7XYd8OKbZOv8Aqgayv+3zZGFKwOw38VtNQiDBMGRXvgWl76uHOKq+j
         vkNg==
X-Gm-Message-State: AOAM532lbOKBhF/cBP83kpNw/DuYtOQs5mR9g8EF1Ijvfvh/oUQiiLeA
        r4EFC3hlJoIPGehy1XMQISg=
X-Google-Smtp-Source: ABdhPJxl9tdpWTHh5kromFvL3xd6HsedGO3y5SpmPIKgfg199U+Ewr19JV/Kv7f3tnBe6Pgj0XEcAQ==
X-Received: by 2002:a17:906:6d95:: with SMTP id h21mr34285853ejt.190.1641338860742;
        Tue, 04 Jan 2022 15:27:40 -0800 (PST)
Received: from gmail.com ([5.38.241.27])
        by smtp.gmail.com with ESMTPSA id u21sm15267600eds.8.2022.01.04.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 15:27:40 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 00:27:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] per_task: Remove the PER_TASK_BYTES hard-coded constant
Message-ID: <YdTX6Mg/GgGvfi7j@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
 <YdRVawyDbHvI01uV@gmail.com>
 <YdRkS1iq6wtgbI3b@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRkS1iq6wtgbI3b@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jan 04, 2022 at 03:10:51PM +0100, Ingo Molnar wrote:
> > * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > +++ b/kernel/sched/core.c
> 
> > +#include "../../../kernel/sched/per_task_area_struct.h"
> 
> #include "per_task_area_struct.h" ?

Indeed - fixed.

Thanks,

	Ingo
