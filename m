Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D490772A61
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 18:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHGQTY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 12:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHGQTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 12:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4E10CE;
        Mon,  7 Aug 2023 09:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1AAC61ECF;
        Mon,  7 Aug 2023 16:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D24CC433CA;
        Mon,  7 Aug 2023 16:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425162;
        bh=RCjQ6vti5d4rtFH23MxMIY1p9y9CRqE3VIV6VqW/Gnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hd6un6urbdSo8Id+eeRkX5erMb52evs3hyzmavrkSLipkH5JoeSegYAEleIKPgW8m
         eCqpQ8tyFKTDbrkIQOjcWFCbDCEadL5BE90GhYhrWrKy8DyiNtUDpVCb9wKrAIN0n5
         GR3e9SYrnuWs5166VSW3z07LbOZpKHk0AQIQaCtKp0/UYVSLdJYe2zZvVRnsMihyBu
         ADfcyrjrnmObHekPQk6C50rl3YxKen9FjqX8MJzqWVLxZT1XGFINUlKXJpDWYtN/rn
         tddHOn4K4Y2Gzh6HOUU0dLMeFYkFyOqXuQ/o21jOnQ01Es7EisJUW8QrEh1CO2SWZq
         84VHtIHuToTcQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ba5cda3530so3670073fac.3;
        Mon, 07 Aug 2023 09:19:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlWDYxnM4qP+ImMBbP1jus1r3vX5MwO5UX0jOHFZYYNMObDpkj
        laPMuifupTAqvqljI1JvoGzCWzd+EMYoa0CbqA4=
X-Google-Smtp-Source: AGHT+IFvChfuLszjtoRr3uXfgd3k35TSz6VMm1GNzaFKTSum1bvO419fx3Nk4Q1aAYASirJws2c6fASuYHU6yNRU7cI=
X-Received: by 2002:a05:6870:96aa:b0:1be:ccce:7993 with SMTP id
 o42-20020a05687096aa00b001beccce7993mr11267917oaq.40.1691425161242; Mon, 07
 Aug 2023 09:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230807154250.998765-1-masahiroy@kernel.org> <20230807154250.998765-3-masahiroy@kernel.org>
 <CAAhV-H7VzqPBYD0o1qAY7v7z+G9xOMq+yOR9ZTcO1SKfCXVZ0g@mail.gmail.com>
In-Reply-To: <CAAhV-H7VzqPBYD0o1qAY7v7z+G9xOMq+yOR9ZTcO1SKfCXVZ0g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Aug 2023 01:18:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnGTZEBokjcqzVyRugn0zQfodED8Jhq8AQdz5qXJMr0w@mail.gmail.com>
Message-ID: <CAK7LNATnGTZEBokjcqzVyRugn0zQfodED8Jhq8AQdz5qXJMr0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] loongarch: remove <asm/export.h>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 8, 2023 at 12:56=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Masahiro,
>
> Is this series only for linux-next (6.6), or also needed by 6.5?

I meant it for  linux-next (6.6).

Code clean-up can wait for the next MW.



--=20
Best Regards
Masahiro Yamada
