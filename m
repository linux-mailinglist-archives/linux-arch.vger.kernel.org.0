Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FD259B09C
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiHTVod (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVoa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 17:44:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846F222BD
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 14:44:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy5so14804636ejc.3
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=06NQ9qvzyXzYoYplFrOhB+72ycso6mDcQFEFIouUsIs=;
        b=TiSoGPMyV1LXSCZFi8l6Fsp9Lx33NzdCRlgqIpt5daXToYuKj+wLIuuUFnGtuKdw7g
         riKhvm29kVdcouqs9IG1aTvUsVR7ES8KPs2aYmFK7sEf/fkP8EjOxt/dO1YOuBYABPb/
         qzljmN+krG1Hvt43ZDKG4bo5espvLX+1tJPCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=06NQ9qvzyXzYoYplFrOhB+72ycso6mDcQFEFIouUsIs=;
        b=xss9J1DSJscQxPuisidtW2I97MzgPbo9T6flMtH/3JtwHwMs+ILsi0v6W5rS9t11e+
         deyIQimyQlDJoZuXBhg1QVCFMBp+rz71REWR1AeSf0zG13WDuaaOBCo7pJ2C9KEv7h8W
         v9q87pkhZH/vP9esRmB2sTlhZ3qyRMt77dOOoiMzmi9XvgP4r5dWycLf0Qz+aQA1cKns
         Z9QW0DRMQQqheQ36/B7aQi2/d6mwNMe/EEujo8YhBwPw/2FotzYVBO69LrDeXvd1Gcte
         pQFeJdKWxOmKssblceLqxQf6srLFIYlVjs8wpRcPuZkRXbTdw9EguJtVvq2s33OFjuRP
         4GoA==
X-Gm-Message-State: ACgBeo3/e6mwZBkWPUIZ86/GrI/wvvPHTNuJFCGiiu4lhw/9qspPOvd5
        GqqhK/Fxajcr0bH87TsCYrl6f1FQkJq5sf6d
X-Google-Smtp-Source: AA6agR7yUBAH+iIxLklu4GJ2JUDmzByZ3KuojCdzTZ4GqBSKb6v3pozFBXSdV7VArVLRV7IF2HjFdA==
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id ga6-20020a1709070c0600b00701eb600dedmr8899395ejc.178.1661031867226;
        Sat, 20 Aug 2022 14:44:27 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id f7-20020a1709062c4700b0073d64fcd8aesm1315428ejh.219.2022.08.20.14.44.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 14:44:26 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso5768983wma.2
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 14:44:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr11227293wmq.154.1661031865955; Sat, 20
 Aug 2022 14:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <YwBWJYU9BjnGBy2c@ZenIV> <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
 <YwErb9MnfTFCmOcA@ZenIV>
In-Reply-To: <YwErb9MnfTFCmOcA@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Aug 2022 14:44:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
Message-ID: <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
Subject: Re: [RFC][PATCHES] termios.h cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 20, 2022 at 11:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Umm...  Might as well, I guess...  Where to put those, though?
> drivers/tty/tty_ioctl.c is not an option, unfortunately - it'll pick
> the local definitions, __weak or no __weak.

IThat bug is ancient history, and tty_ioctl.c is just fine.

Yes, we used to have the "you can't have __weak function definitions
in the same file that uses them" rule.

But it was due to a bug in gcc-4.1, which would inline weak functions.

But we long since gave up on gcc-4.1, and we have __weak functions
declarations in the same file as the use in multiple places. See for
example arch_release_task_struct() in kernel/fork.c.

                 Linus
