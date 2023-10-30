Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE91F7DC016
	for <lists+linux-arch@lfdr.de>; Mon, 30 Oct 2023 19:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJ3SzK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Oct 2023 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJ3SzJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Oct 2023 14:55:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54425C9;
        Mon, 30 Oct 2023 11:55:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a62d4788so7354944e87.0;
        Mon, 30 Oct 2023 11:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698692105; x=1699296905; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2XCZx3/R8oTKYE9BrmrGqp1BsnPUxRKC3gA5ci6I/8=;
        b=JqexuX2vJC9ActXb+o0bri/ThFiNUW6k7XpgAE3nvWw6e5uB/2iKGmj9nBvVfxn8XI
         pxohHH1SIFVFuU8giWQrXyx9i3lUj6Fdw8KpbtO/16v+eUepEycn19fD7hwAKGU61Pib
         /MRvD6TriIbnUXKGn9tD53+HGaySEmH259fYJMcN7McJqWPVtnNivrt5J+dgSh+S1yNk
         ttFHC/5K18vnjuRpvYbSWqstwePMBEjpwb5CLqj0kU6rYIOMOLf4fPiKcfxAtzUce5Zp
         Kh0xQQPHQIT62FBUiBvuSEjBKZYBjvu5ijFfUdg75Tzy8osGtZRw0bFP0lHzZ1iuVX64
         CtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698692105; x=1699296905;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2XCZx3/R8oTKYE9BrmrGqp1BsnPUxRKC3gA5ci6I/8=;
        b=hFt/fV/4vkbhyxT/Ikes+c8p5OqEPPa6+sGPhrFiASGby4koFflwNuOiaKtfFOXQ0x
         Xx0SDb64JAaTPZsezy78xeEoPdbYNDH/ONaPm3RRgTVFsyFKXUDpSkejAUTEHRFjKOIM
         HC0aFnZxE+fkcXM7+RXhpnHd/i7wQf6ElbbVodvIu1Fpp+PzE70jIhmd/ql7LSHExCpm
         32JJxLCHs6NX6Ft0iw1+eKs4YtXEa5r1jHuAz0fn7Jd2LKNUPnRUCIgS69i2NtBB1VXz
         PCmkQGED181+LLoQSHw+6ORpyGtpjMv46nhlWU9NnVUOekM96XW1XoFN0dqgAR8ipQsf
         thrg==
X-Gm-Message-State: AOJu0YyxKTTMbe0v6SKsaGGG6btQVWPx4zaZY6uaFLx/BhQRy9ynDlhZ
        IyJTZfDAAMX7UScF7EDuZQe1axT5ZtmEYW9Rq7dxnQtwhec=
X-Google-Smtp-Source: AGHT+IE6WoBwH8gKIBiQqPqjspRYmpmf+U3WZyH8EbrefUW8AUExz5DewzlpcghkhpT8+5xE4BreuwgC6oMgZH+3B60=
X-Received: by 2002:a19:f713:0:b0:507:a33f:135d with SMTP id
 z19-20020a19f713000000b00507a33f135dmr7734946lfe.4.1698692104665; Mon, 30 Oct
 2023 11:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFeDpyjv7_PHNXw@mail.gmail.com>
In-Reply-To: <CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFeDpyjv7_PHNXw@mail.gmail.com>
From:   =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
Date:   Mon, 30 Oct 2023 19:54:53 +0100
Message-ID: <CAHtyXDfxEsUM-=EtK9sVPZQ65UL3LxvYL+0HU5+rdfedaM9NFw@mail.gmail.com>
Subject: Re: ia64 maintainership (resend)
To:     linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Update: next-20231027 still works on ia64 after reverting the removal
patches with only a small diff needed for it to build:
https://gist.github.com/lenticularis39/af031432f8b1c8f2ca1da94ebe144378

It boots just fine as you can see here: https://i.ibb.co/vLQq0NW/obrazek.png

I haven't run any further tests but it's a good starting point to fix
Itanium build should the breaking changes be merged from next and the
Itanium removal not.
