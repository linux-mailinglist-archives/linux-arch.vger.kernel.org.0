Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67334CF19D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Mar 2022 07:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiCGGH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Mar 2022 01:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiCGGHy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2022 01:07:54 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623A5F266
        for <linux-arch@vger.kernel.org>; Sun,  6 Mar 2022 22:07:01 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id f38so28886083ybi.3
        for <linux-arch@vger.kernel.org>; Sun, 06 Mar 2022 22:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=iGE+czjVEDLwDaXqyAMyQbTH4V3AuDBw1aS+YOCk9+wj/EA2P6VJonuqQd8mQkvXeg
         8/Pahn2vJGAgPzbKSV6i8kwMUkZBTvlLzxWMkP2U53DE79zDA4HR95BHw/I64qH/vLUM
         Yqq7d0l0nFtKaIe6JaJqOy0HP7u3QfsSV8Z2Tw22y6DJ1loolTkL68hJEMuhTaPh0PUU
         uBT4F0VzRaEviubJ+j7o5PkavmgVl4Souf4fT0zGOJ6Y+eSKhDnO3tk19VeLaIvRXs+l
         MKNllI+GXBxNNWc/kmyf/0v6XW6qmqNpPVue11mVQHThfymq3YaAXLvcuYJzWivrcfWF
         INlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=mnBqnj+FD+vViOfzD9E1zJtvFjL4SjhKz06MkVFLgNyODaVZxAc4+clneztDWlcBeZ
         +DqwSWgBCZPNzhDZdmlAcT0OvyF5aTtnolu3NtxXuMw4aF28OyImqMmkUGVGfMDxQo2q
         SRO55QaARJkgx7Xc7dAcnyvQhw//Q/h/XFvSR8tZ3E6+5+PMGC77YNIy70DeYJBwZHzo
         yggT8AINp/1zgB54i2cPDcpKULAO4VdzKEts4IL7hpNUCcDUFbGWphr+cNl1PwjPDaMB
         YK9/op4zAYYS5qeO7UmTKbv5c77o99j8S3y6fMuE7XD9gJFErw5idw5Y7X9k2fUAeX42
         I0HQ==
X-Gm-Message-State: AOAM533xQ8n0rV6itQn7bNp640sv4cutujMKMlG9Fdck64HfhMO1xZct
        xH7U/b/RDpfQPmboIeM4i6IMkHxYob6Ct5qXoaA=
X-Google-Smtp-Source: ABdhPJxuhR2pwqUaSnOJpTPOqcbnt7kUl22w5/g5PdeS8bEodwWjKeDNXFp4dPQjjWph/1M/PpUq86RZBV42jZSgV6k=
X-Received: by 2002:a25:8911:0:b0:61e:1c66:17b0 with SMTP id
 e17-20020a258911000000b0061e1c6617b0mr7148766ybl.354.1646633220141; Sun, 06
 Mar 2022 22:07:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:b986:b0:a4:b698:78d9 with HTTP; Sun, 6 Mar 2022
 22:06:59 -0800 (PST)
Reply-To: markwillima00@gmail.com
From:   Mark <markpeterdavid@gmail.com>
Date:   Sun, 6 Mar 2022 22:06:59 -0800
Message-ID: <CAC_St29qRteuBbog0XtWwNmktrR6tpp6ag4vhqoHjB-vuzvPhA@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [markpeterdavid[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,
Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
