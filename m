Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44F30EF17
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbhBDI4R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 03:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhBDI4R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 03:56:17 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B42C061573;
        Thu,  4 Feb 2021 00:55:37 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id y17so1835135ili.12;
        Thu, 04 Feb 2021 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgqtCgxTyEkoatPNuk1/d0sbXAfUIl1+10KCCoubueE=;
        b=jCSq/9Hh63zcQprobHHi7fqAMnr1T2L7KH/Q67a+uu2UEN7CgnIVX9A/LLfm03nbg9
         H1kcCYOYwyB05dsLtHzVaxu3Eu8hTeCsidcToCnq7LqWtlcCu3b4dy+REHvnfFQHMEkv
         T3QJZLfLx4DHBGXRzSHVJhiXCC4vTsrYG9C2wdGN8hSkoQJIZgTUyDiSMQjS7Pl9qwnY
         hulCbu3rHsOdcJxUd71ivdXusLLRfzVnIQbAql6TAqa/gXW8g3DTQqB7PnoAU5hFePA0
         7dc/unNnpjdRZcKVXxACKnwAXq0U82J0rfR8QoHAp8pqGL0HRnb0ebxTsYnIoo1AyJdr
         5lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgqtCgxTyEkoatPNuk1/d0sbXAfUIl1+10KCCoubueE=;
        b=AzKIHMIQRHMr7kbTx5pBLTFKJTnvTcEAsrRzKIGGB23c43ftUZt8qOVPP5p+d1CuzI
         VLuEQnOlQMl88fEogyKTMv8G1pU17exlg1139MnX/IcEA8N5kDPAX1UdM4bAaNP/ze4U
         hK9wWZRpR6eeMSjmFVK97aoYqBtBMRldTszUkrnN5yDpHGx2TbIDH845h+d7MMQNsobm
         apXpH0HJtrDeNCZwc0gay5p62htAImfyBqF1rKhePHUfFIxe9rZae3qX7zyz5FBclAdl
         QLNcqGtAmi7LzkGafga5S4Xzhv37+/IOwpdcAe1MMT1ebpfORWZ3H6YDS4lmRVb+HW+X
         4ynA==
X-Gm-Message-State: AOAM530HcKqt4a+zVwg9Arpn1+H7xPFgbbbQmIQcVSFvwTe+PVRJb/YE
        STSIR3MSwwiK6+gchO6h2NbzMxzGvq6Aqro8WpKAKEgDuYM=
X-Google-Smtp-Source: ABdhPJz9k6ybKd/Iiv1NxWPmTbfh043bu1P7WPQnmsZo7oVbMtqG2ILSVjiEDDVCGcHmpd+YXWLg0ahrVxJ9GSai0fA=
X-Received: by 2002:a05:6e02:20e8:: with SMTP id q8mr5961862ilv.205.1612428936646;
 Thu, 04 Feb 2021 00:55:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <da4eaafa84f32375319014f6e9af5c104a6153fd.1608963095.git.syednwaris@gmail.com>
 <CAHp75VcSsfDKY3w4ufZktXzRB=GiObAV6voPfmeAHcbdwX0uqg@mail.gmail.com>
In-Reply-To: <CAHp75VcSsfDKY3w4ufZktXzRB=GiObAV6voPfmeAHcbdwX0uqg@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Thu, 4 Feb 2021 14:25:24 +0530
Message-ID: <CACG_h5otB5hhAX0z9YzN8bT6Nz5WVRUQWbhENF+u8Z3WsCp_8A@mail.gmail.com>
Subject: Re: [PATCH 2/5] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Dec 26, 2020 at 8:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Saturday, December 26, 2020, Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>>
>> The introduction of the generic for_each_set_clump macro need test
>> cases to verify the implementation. This patch adds test cases for
>> scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
>> The cases contain situations where clump is getting split at the word
>> boundary and also when zeroes are present in the start and middle of
>> bitmap.
>
>
> You have to split it to a separate test under drivers/gpio, because now it has no sense to be like this.

Hi Andy,

How do I split it into separate test under drivers/gpio ? I have
thought of making a test_clump_bits.c file in drivers/gpio.
But how do I integrate this test file so that tests are executed at
runtime? Similar to tests in lib/test_bitmap.c ?

I believe I need to make changes in config files so that tests in
test_clump_bits.c ( in drivers/gpio ) are executed at runtime. Could
you please provide some steps on how to do that. Thank You !

Regards
Syed Nayyar Waris
