Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF062604F7
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgIGTAp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbgIGTAo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 15:00:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CDFC061573;
        Mon,  7 Sep 2020 12:00:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f142so13277003qke.13;
        Mon, 07 Sep 2020 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ultTVCKnbL0cIumvbgd7ADKxSHF2oA5ehprjQ5o8rqk=;
        b=e6MazpFS87eyfhsvP5SIHx/6VfEUnHBrUiLWp3wdL+HWhcFkHJDxPDKteAK3DlZp1E
         Rgynh8mtC+gLFAQZA0nd7WsZtgIS4HCIqn27Gv2voq5mATpxxsKkka83COdKlwz992F4
         WjyvlzlxZOFeOCWgCKjhXsHk8TP0BoaNSc4+qCbZPaf3bX0wCE5438H7dpr6m8FCfPtp
         8ahuPEj4Zxk3wHsV8xt+g/b+DLmEUAu7bO6qTNB15+yt5aoO35aHaNcejkllEtqPw+H0
         BeqMkLB0H2yNnKZKbB9WdUJicI9PW44BizacEaib2rHnYmWHtDAS9HUQ3HaL02E1jhyO
         62+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ultTVCKnbL0cIumvbgd7ADKxSHF2oA5ehprjQ5o8rqk=;
        b=pUnSmxz1HG+wOIsN57fW2rKkYvp4lTwXD7iAdaVOENWq6C2DyZ+a6A1lDw16t/0V2n
         HrBZKge16OG7WrgBLmigd8ladSVNLr5LpF/XRvMwcvwvNuHvDJ98x4p1rK5w+Z+SuJWL
         wUNlMSCMdT0raQAEbVss0y9E6wRcLLEYkv0KCvy3pT8vba9nqnEhsfEnN878Url4gUKF
         0m6otz5Zlg1ail1X6Qq771cQLdx31cHjy2hMM7LZIgbbYMw7twBavXehh7u1PT2Sdqvs
         L5FDwr9lZleoJHeQXngxmmUAQ/Rm327K6P6U+64k92FVKLxzFnVzLfiaIE7CTaWV8GBc
         gq3Q==
X-Gm-Message-State: AOAM530+l8W3ygimjX1qk4JgTyjRY+/ND8+tvEuk/2OO4qmrRg917d/a
        fdaFGsWXzSW6kD5qQ/dJqzBnZOEE1bRvpUXb
X-Google-Smtp-Source: ABdhPJxeXvjlSJQKbLzEVALgc3IMCWp4kC/aFtw+p3ZZy/g6vq86BDAIZ6YYdN+LTmjXG+xAdFUzCw==
X-Received: by 2002:a37:b942:: with SMTP id j63mr21001589qkf.138.1599505242410;
        Mon, 07 Sep 2020 12:00:42 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id x126sm10429098qka.91.2020.09.07.12.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 12:00:41 -0700 (PDT)
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from, to}_user
To:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200904165216.1799796-1-hch@lst.de>
 <20200904165216.1799796-4-hch@lst.de>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <86bb5644-fd97-8e54-9e5e-aa961680afd3@gmail.com>
Date:   Mon, 7 Sep 2020 15:00:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904165216.1799796-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in raw_copy_{from, to}_user

nit: handling

--Sean
