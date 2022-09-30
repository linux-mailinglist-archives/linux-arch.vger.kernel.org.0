Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1546E5F0C8F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 15:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiI3Nll (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Sep 2022 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiI3Nlk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Sep 2022 09:41:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252AF14E762;
        Fri, 30 Sep 2022 06:41:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u12so4319253pjj.1;
        Fri, 30 Sep 2022 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Qoz8AmbfL3c1gEhb9RhVqolO2Z1Q7cU3//oNxnT6QiY=;
        b=lEw9Md54Prt5CXkYBqczlMBRAszMS3UrSUYyupvUcYRiqO09gvfojW/5clCytriixS
         2808RzoaDYp61oGmZ99HmIzUJaXUj7qfptMeNj8c1POWwsxVBHnMHW5eHJ7eVQ7kbJDC
         37oHvD+l3+mZZkvB4HR+RV3QXcBs3Gnwia+aka0g/Bvx7s3rv/S2+m7ycYVFA2NzegCX
         /VsEROR/dBjvTPWylKYne89QtOdOnn5GiizTeDaBCCfx7hMKZMbopyhPWIhn0wZrqUzL
         wrYqvyrKk7qj4uPS45mcn+WYnyuTZA/rt/bZ0E3bFtZj/6l/7vBHpzi8rbbKXc0catvl
         XBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Qoz8AmbfL3c1gEhb9RhVqolO2Z1Q7cU3//oNxnT6QiY=;
        b=MDZFeLuDpb2ZdI4/7buaDxUio3smlPEdN+egonP28qT5BJHZ8xFD10fXewknn/YJR4
         IzEy1J6tlry6GF9tQXCstbX01/TfZQ5d88LpQqqZt9BDfUdftHpS5tUjpMChNMQFlM/5
         GTjqwWUDPEeH07OvenjBJ8bEsU/7G6Xuwy7Im/KbmZHrMBLryGFvGqhSu1H0Y5JK30dS
         zK98GZRTNVM5turaRlwPfpImJUKlP1Q8WVh2L4IeFrZ/CrkvIPrq9lQPp+0uLHSkVR7Q
         N8kbzCFH53uBx8n8SMREF66oy/OG9egRj1Crm8SK/xlJ8dMMxXcLhGwMn0vVl5OU4e/q
         OkvA==
X-Gm-Message-State: ACrzQf0rxbnDJhIACMBtAoqMMSh2v8WuxdIaYCbCgjgEJUYvs4e9fFSP
        qRqVE2UL5MwMp+OxHNpKWlDJZaDYlUkreg==
X-Google-Smtp-Source: AMsMyM4Kafj66tGKNKwprqNaME3IQ0fN09pKpo4y9u0Is68u+11h+++UwFTbdVUZJ5J3UYY2XafLRQ==
X-Received: by 2002:a17:902:690a:b0:17a:32d:7acc with SMTP id j10-20020a170902690a00b0017a032d7accmr9017854plk.18.1664545298630;
        Fri, 30 Sep 2022 06:41:38 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id j17-20020a635511000000b00439c6a4e1ccsm1667305pgb.62.2022.09.30.06.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 06:41:38 -0700 (PDT)
Message-ID: <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
Date:   Fri, 30 Sep 2022 20:41:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me> <87v8p5f0mg.fsf@meer.lwn.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87v8p5f0mg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/30/22 20:33, Jonathan Corbet wrote:
>>  CET introduces Shadow Stack and Indirect Branch Tracking. Shadow stack is
>>  a secondary stack allocated from memory and cannot be directly modified by
>> -applications. When executing a CALL instruction, the processor pushes the
>> +applications. When executing a ``CALL`` instruction, the processor pushes the
> 
> Just to be clear, not everybody is fond of sprinkling lots of ``literal
> text`` throughout the documentation in this way.  Heavy use of it will
> certainly clutter the plain-text file and can be a net negative overall.
> 

Actually there is a trade-off between semantic correctness and plain-text
clarity. With regards to inline code samples (like identifiers), I fall
into the former camp. But when I'm reviewing patches for which the
surrounding documentation go latter camp (leave code samples alone without
markup), I can adapt to that style as long as it causes no warnings
whatsover.

-- 
An old man doll... just what I always wanted! - Clara
