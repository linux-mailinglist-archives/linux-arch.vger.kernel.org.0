Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09AF4C1543
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 15:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbiBWOTV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 09:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiBWOTU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 09:19:20 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54358B18AA;
        Wed, 23 Feb 2022 06:18:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q17so44681252edd.4;
        Wed, 23 Feb 2022 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCJdYpST4AVctkMhBk/VRWL1mrSDLK+1/ZK+NiYaHwM=;
        b=fymlXidAfFdrM2eCxvVvcwEwJ7xdoBaA45CIybeUKMMm9Puu6T9lF5CJa5x7f874PR
         TPiF3UQRSz0lW3/bWof1bRA54zvz3M6Vm4cI2n2MVrWL2q4zZxFABxQSWmjSdjlPlFVJ
         5faUh5/VR7GaFJ7hVO0os2pgLsyYU4gyQHwz/EafAuLlZGXkYK3LpEMO8YwrSRgoSQt9
         6acUELJsSeVCn+e7FQSSeb+Du/hLOHV3k0miyTY2wB2hEB0ByDhmDQKiHIF/g79opu6u
         qsVwS62YwM/o1GuJqA9k7sQcv9D8MkJu/h+w06Le0v/9A4dtiH0VGhcba+/qJ1pdq3US
         cfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vCJdYpST4AVctkMhBk/VRWL1mrSDLK+1/ZK+NiYaHwM=;
        b=MOYrPjbV4+ZBic6VGrfRELKjt4ixadXlB+RoS3j45gFpEJFRvsYgfe//hnd94vhaGQ
         7sxCPfIChPcvjZNKDcbsO0GCqowW7Npm7T2wbMDKAnGNpLnojLE1b93Wpbwn2PRmC5y2
         JojpnDxBv1FrmdZCtFVyEop4PoFx63mc4ZeA8pFvVHNYLvKfmSxKEzoPdEQUXnziqdFl
         uWA3Ktj9H8wyZ8Bw6kHq1xhfmQLP2cU7E2mSDfeGxQB88uPFLFA+C0EqO0UrLZFbwWI0
         S35BxY75EeHzsI9N9vQz+mCssUf/x6jJ7QBtEy4d95nAL8QNHjplM562ZqbDJTsHhvIL
         EOnQ==
X-Gm-Message-State: AOAM533fmk8686LUPL+srngoeEcLg67bfq9IVEXdmgOzR25mCXPPXPQd
        d1HIBeQMyAnL/w3ff7XBtic=
X-Google-Smtp-Source: ABdhPJw0/XrCpD/UPSifYjYmrvpzUyWNkReL8cWDJb1hIDJZ/b6WPXQgyAk9sn1fdSlBZp3HfqlYXg==
X-Received: by 2002:a05:6402:90a:b0:408:4f50:c566 with SMTP id g10-20020a056402090a00b004084f50c566mr10971450edz.41.1645625931949;
        Wed, 23 Feb 2022 06:18:51 -0800 (PST)
Received: from smtpclient.apple (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.gmail.com with ESMTPSA id p4sm7550773ejm.47.2022.02.23.06.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:18:51 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
From:   Jakob <jakobkoschel@gmail.com>
In-Reply-To: <20220218151216.GE1037534@ziepe.ca>
Date:   Wed, 23 Feb 2022 15:18:50 +0100
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: 7bit
Message-Id: <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
 <20220218151216.GE1037534@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 18. Feb 2022, at 16:12, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Thu, Feb 17, 2022 at 07:48:20PM +0100, Jakob Koschel wrote:
>> It is unsafe to assume that tmp != mdev can only evaluate to false
>> if the break within the list iterator is hit.
>> 
>> When the break is not hit, tmp is set to an address derived from the
>> head element. If mdev would match with that value of tmp it would allow
>> continuing beyond the safety check even if mdev was never found within
>> the list
> 
> I think due to other construction this is not actually possible, but I
> guess it is technically correct
> 
> This seems like just a straight up style fix with nothing to do with
> speculative execution though. Why not just send it as a proper patch?
> 
> Jason

Thank you for your feedback.

I've raised some confusion here, I'm sorry about that.
The idea was to change list_for_each_entry() to set 'pos' to NULL
when the list terminates to avoid invalid usage in speculation.

This will break this code and I therefore included the suggested change
in this RFC. This RFC was not intended to be merged as is.

However, in this example, 'tmp' will be a out-of-bounds pointer
if the loop did finish without hitting the break, so the check past the
loop *could* match 'mdev' even though no break was ever met.

I've now realized that this is probably not realistic iff mdev always
points to a valid struct mdev_device.
(It's a slightly different scenario on PATCH 03/13).

Jakob
