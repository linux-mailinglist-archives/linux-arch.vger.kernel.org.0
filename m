Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00356C6915
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 14:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCWNFt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 09:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjCWNFs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 09:05:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7FB32509;
        Thu, 23 Mar 2023 06:05:36 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i6so24698190ybu.8;
        Thu, 23 Mar 2023 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679576735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gucyIJVMKP+NqT9WF5OyPIqU6hJihw7ITPbLS8iJbWI=;
        b=GOGeKOJMQko4GNrdrl0mulhsICJWZdDn90U2cKkLhGP54YTFtiZnLSOnlzxNCdR87d
         +JK8pY3IBSYeUY2u1ICxEfLMdLl/Num/+fjmL2Hh+VO087ynS7XLoAqedR3r4uwD9E8q
         zJ+m2gOMkiDGlB8e9jOsPen071tSUipsLC1Jkwb+ukVcRZ8y+3cG4GJTRXs1eoYy45YD
         Y5OByw1pywvSMjoItJhsl3UD37TQj10qN+muJ3COOPImgYlOALIHF9lOppGtnXMjjZLt
         EGGJTB7K0fJ9WAVJo3KgwdfWbrqgMlvFy3AVJ3Eh7Qard/+N5PfXMGCe/PiVmgjx5ufH
         DmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679576735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gucyIJVMKP+NqT9WF5OyPIqU6hJihw7ITPbLS8iJbWI=;
        b=JwRK5RnolPDFvVYisoYT4BzTNAW+RYYzOyGIaPx/2NV3nSYEuCUxcl5IRLIFbL6lTg
         m8HEgWyQECOwlKbP8KR3ct/bvcxXItFrAjGHxz+py2k6BLd/1qo3uc1cy5BlHpmLk5LI
         2ETTOam+wXk/Eudl3ju+izAYi3ZkTPJpQl043NObrfo3XU6prtz0+kUyfSf2j4+d9lH8
         qOOEroNzd72nEmFOlk5JVaTm+mnDtHekkuPKC7wiUId3GWP2B6jnnRvPdwd8C05s1EwZ
         G4F2GzX0LcEqhi+NVj6U3yqzPhosjNt86B6TlE5nw2HpenMYijBG0TZZfHcRFNwQQ3sJ
         CWpQ==
X-Gm-Message-State: AAQBX9eh65Sz8DmcpClaltkZPGD3lY1p8VyHd1SZ+2jVy6hDrnBtEMSC
        x6HvrU+xOnLwIdkaXEGzVxv7X96jjL1i+Vm5/pY=
X-Google-Smtp-Source: AKy350amHGvdoGB6oMTdWl9KkL9uI8iQ8PXcVN7k41xhsfQsfPgZsU8wJ6U8gAoeENI2187lnxyCHxpSc/TinLiE3pk=
X-Received: by 2002:a05:6902:100d:b0:b6d:fc53:c5c0 with SMTP id
 w13-20020a056902100d00b00b6dfc53c5c0mr2121997ybt.1.1679576735709; Thu, 23 Mar
 2023 06:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-ioctl-v3-1-3c5f7a6954b5@asahilina.net>
In-Reply-To: <20230224-rust-ioctl-v3-1-3c5f7a6954b5@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 23 Mar 2023 14:05:24 +0100
Message-ID: <CANiq72nk+KSz6X0Lxg4kc_Bui=17XhboJ6q6j8gRg7Nsshziug@mail.gmail.com>
Subject: Re: [PATCH v3] rust: ioctl: Add ioctl number manipulation functions
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023 at 1:34=E2=80=AFPM Asahi Lina <lina@asahilina.net> wro=
te:
>
> Changes in v3:
> - Actually made the change intended in v2.
> - Link to v2: https://lore.kernel.org/r/20230224-rust-ioctl-v2-1-5325e76a=
92df@asahilina.net
>
> Changes in v2:
> - Changed from assert!() to build_assert!() (static_assert!() can't work
>   here)
> - Link to v1: https://lore.kernel.org/r/20230224-rust-ioctl-v1-1-5142d365=
a934@asahilina.net

It seems `#[inline(always)]` got added to a few of those, right? (The
addition looks fine to me, but just to understand if is it an omission
in the changelog, or an unintended change, or intended for another
reason).

Thanks!

Cheers,
Miguel
