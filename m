Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7805B6AD279
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 00:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCFXB4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 18:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCFXBz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 18:01:55 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFC637C6;
        Mon,  6 Mar 2023 15:01:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h8so12207301plf.10;
        Mon, 06 Mar 2023 15:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678143714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFvaNQYUtK3/GzIRP4wfkaFrx608yYNRKbg0aOKiIdo=;
        b=jGkX9bczrnZfe7qhlgEPntSvlGYcNl02gax5qBYne5xhtKngRdLaJmPmXiwD1QlT9H
         /EVVKqr1PZp/QIr4pCnwXHP8IoycaduQqu6gi7WqGTQcod4mL6xPdLIm3htDAh05tfrD
         lrmZyiBao7+zc1XOd7hZY6ECaHr2Oj18Sc4jzlO/oPOAXnPRxe2YGdFd/wHEsff0c1ml
         pXcBCTHTWidAsi0DdPZ14b4oAZZ7XYo8CXvyo5q1+Q5H+I9K5/Dy2JdXHkCgZ6ccqEDR
         Mcjj+lyZkZZAIj78DuPSpESgbjOsziTSttLugaXHz6PhBAcsPjtpGJZOF6zNy3Tnjbys
         SIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFvaNQYUtK3/GzIRP4wfkaFrx608yYNRKbg0aOKiIdo=;
        b=kSUyN7dkSNWtzSPuY3i/U+8dgURI9m71aS5M4hzNQwV+9ldgG43etLvw0j8Nw+JGg9
         VswAzg+ujOJ1TfoWj9HEzA/THeRC+urkx2bbNmwmjNfuNv8o4OHED3xbpCJREt2+tVSP
         I653254d5x9te37ye/WqNNVWOXXQvHAwKgNcUJeDYraHs0iR7TV+Dl1IM79A96JxFwyw
         Eyy2XbNKpkfpgHhf+yC8MNhIxJdCRqxEFoI49T1jsyrk5NPLuhEy+bJrXHknuvNd8h/8
         7N6dYy6miWnKzMvAtr2CEgzkdniEBxu2dQUpBJ4mjyIYd8irkQWcD+3R43PiW+EaDSTf
         9o0Q==
X-Gm-Message-State: AO0yUKWl75uM9X9lDB4YRVQJuDI++6McxTVkRfXE13COKnH7KAu8VibR
        8LI/tBu6LtZ4pGnNsCJSF6YVkkX6ewU=
X-Google-Smtp-Source: AK7set/Vj8UXjS8rj40zM4+sO9o7q139gb3UfaWLkIHkIeZPS3jYCAzX7WkSDGyNppSvZ6bUWJZOZQ==
X-Received: by 2002:a05:6a21:33a8:b0:bf:58d1:ce98 with SMTP id yy40-20020a056a2133a800b000bf58d1ce98mr14277840pzb.23.1678143713866;
        Mon, 06 Mar 2023 15:01:53 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:30b0:fa2a:478a:23d8? ([2001:df0:0:200c:30b0:fa2a:478a:23d8])
        by smtp.gmail.com with ESMTPSA id n1-20020a6546c1000000b0050301745a5dsm6754962pgr.50.2023.03.06.15.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 15:01:53 -0800 (PST)
Message-ID: <5f556597-5f09-6baa-80bb-aef7337ae869@gmail.com>
Date:   Tue, 7 Mar 2023 12:01:47 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 13/34] m68k: Implement the new page table range API
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-14-willy@infradead.org>
 <CAMuHMdW5TtUeZDmtHvxw+DxqUADC-OCW=tHE2Gptcoie62T+4w@mail.gmail.com>
 <ZAS1Lq6//oO/0PXe@casper.infradead.org>
 <0b00a30e-cb7f-d42b-7d16-0ae8d50ed916@gmail.com>
 <CAMuHMdUDrOD3DezbvxaJH6CXxDFRNC7G-8uU7mqVHxZcG6GNBA@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdUDrOD3DezbvxaJH6CXxDFRNC7G-8uU7mqVHxZcG6GNBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On 6/03/23 20:21, Geert Uytterhoeven wrote:
>> Are we certain that contiguous vaddr always maps to contiguous paddr?
> For a general __flush_pages_to_ram() function, that would not be
> guaranteed. But as this is meant for folios, it must be true:
> https://elixir.bootlin.com/linux/latest/source/include/linux/mm_types.h#L320

Thanks for explaining - that just leaves the problem of cowboys like 
myself abusing __flush_pages_to_ram(addr, nr) with nr > 1 for something 
that isn't a folio. Maybe a comment 'nr > 1 only valid on folios' would 
help ...

Cheers,

     Michael

>
> Gr{oetje,eeting}s,
>
>                          Geert
>
