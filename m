Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26208166AFD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgBTXcR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 18:32:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43901 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXcR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 18:32:17 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so240837ljm.10
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 15:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWeBp/urnK4tuGJfqV9ZFGP9TrjtClq354zSDpIQQfY=;
        b=GZX6OFO7fkNUS1d3TzfeLavrKb+nZ6HWPMW1jViAB8AtYBh8cGv3whtpphDdik8l2K
         YtIl2m5ZcTHKKQ1z0FAj0P/4veATqWxebKwQxOZ0rcOFdozjfQo2RaKvMYrD/UncZu93
         6QiaHgv/uUMuDaodJwlKgm24Ve6MdwTVPf/lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWeBp/urnK4tuGJfqV9ZFGP9TrjtClq354zSDpIQQfY=;
        b=Z5QoxsJ22ZxS0n9k6ePgJXdf/AN25VHjKdJBcuUc0NU+LikKTLNk9jn6UJzs9M0m93
         xpNcok0X4s+Ss6Z1YbkCzJ4OhJoWGQ1DzuaZvIe5s1zCYMOpK4pRtkQjQw+mQU3NECed
         O3QTVdgL5rE+9U6ziOuKb8UcG4dlxgz2f4rWlzK+tRO2Ejp/YcB7gUsRoL3XwRw4bn3D
         ZN9vuw3IK5NVMsYL4oAjjIVyU7SWhqbSqGmOf+uyy7MiwvyA4uyVUwwElARKOygiikxE
         al4pYdoKBluPEhvTTIdGpNq4G+AmevUZfCg7nfpSB8h7a2yiOzCYwDW9m7XCPOCgZc0p
         rZrw==
X-Gm-Message-State: APjAAAWfP1npKVERc3IFU4NhHhDbZryMkWnMSmDCOgsorMJv2Ri02bbz
        JQU6Q23fJqB2dPlH25wcaMYeE1K6iHw=
X-Google-Smtp-Source: APXvYqzzJIsoYzsifUABHeLYlWRtNCZ9QRmlOVQ4jpz8rREF2IPJv/ywv6q3ibMxheSeNCc6MOuC3g==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr18598506ljp.32.1582241533459;
        Thu, 20 Feb 2020 15:32:13 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q26sm520390lfp.85.2020.02.20.15.32.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 15:32:12 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id b15so98503lfc.4
        for <linux-arch@vger.kernel.org>; Thu, 20 Feb 2020 15:32:12 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr18104253lfb.31.1582241531956;
 Thu, 20 Feb 2020 15:32:11 -0800 (PST)
MIME-Version: 1.0
References: <20200217183340.GI23230@ZenIV.linux.org.uk> <CAHk-=wivKU1eP8ir4q5xEwOV0hsomFz7DMtiAot__X2zU-yGog@mail.gmail.com>
 <20200220224707.GQ23230@ZenIV.linux.org.uk> <CAHk-=wiKs7Q2DbP6kk8JQksb0nhUvAs2wO5cNdWirNEc3CM-YQ@mail.gmail.com>
 <20200220232929.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200220232929.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 15:31:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
Message-ID: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
Subject: Re: [RFC] regset ->get() API
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 3:29 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> We do know that caller does not want more than the value it has passed in
> 'size' argument, though.

Ok, fair enough. That's probably a good way to handle the "allocate in
the caller".

So then I have no issues with that approach.

          Linus
