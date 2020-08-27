Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7B254AC1
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0QdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:33:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgH0QdC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:33:02 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MsZif-1kU7CS3wCJ-00txih for <linux-arch@vger.kernel.org>; Thu, 27 Aug
 2020 18:33:00 +0200
Received: by mail-qt1-f179.google.com with SMTP id t20so4973146qtr.8
        for <linux-arch@vger.kernel.org>; Thu, 27 Aug 2020 09:32:59 -0700 (PDT)
X-Gm-Message-State: AOAM5336nXuVPEcW/+e0fwYtYdQ6621/haTaDpyjNYwVjIyf4YQZrUhQ
        uR75eTJyJBL1ZmiN9L8NHvxTMRlOt++oF7Q79GE=
X-Google-Smtp-Source: ABdhPJzcEPxstA57iaAtLBdMdGt5Kej9ITJHQBDiFeLDokDDhPBLQQYuDq2xR48ONUXH29TJkqdffrEozR9/5jNlIc0=
X-Received: by 2002:ac8:5b47:: with SMTP id n7mr3155802qtw.7.1598545978799;
 Thu, 27 Aug 2020 09:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
In-Reply-To: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 27 Aug 2020 18:32:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3DKxcTkxcfPbcJE+ykVj0tRz_JO64KkSy8NH0f3S5HJA@mail.gmail.com>
Message-ID: <CAK8P3a3DKxcTkxcfPbcJE+ykVj0tRz_JO64KkSy8NH0f3S5HJA@mail.gmail.com>
Subject: Re: [PATCH 0/1] clean up the code related to ASSERT()
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l1l55llVD1q2ikTi/bZRLtzSl0kE5M7nDIVWZ14ZxhjEpPhQT4P
 sWHkT9HSLVu4i0fbc/W/vGQSqUZjCzrLKIH9ObqMQYKLP81wF6rXcP+8SxuujEMnLR6MaE6
 BSSicb3d4u6E3toeH+V24du8len6e4z2RlCCFh5NslfpgOLiuTNcV9EgvVoK71zKRPsNoYN
 v4Ejf1f3ObJO3RsOffgiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bum/VG9nHTA=:xMVPgxcC/bydCHz5zdvqfr
 yZ+/xFTBBTVvWIyLQXZkr38xWiwZUNSXu2GeOa21D+STmAkEhP7L0UP9SNetob7ix5Ahhj53v
 Y92abzTd/ufLyVKFGRBJHIJLQDLqXXjo2MzntwvAMESMymS55zDNu7SH8mlKMCIdAK6yTGbnI
 sMSEavqzJnzTZi2ZYnlQBYMgSgsUI2dNnDjhA3LUeItU+WAK4DMTBIkyeMkktJnaAt06VKYKL
 ni+WBPBlFNTLPsR9vbIKEpLNKLZdXhtKstsZ263yKhBwI1LeE3lV+bVRPUCQNrREtMb7obCgt
 YSSFaQfqrVfBpxLszfNEpDDkWozgHA4iajP9OH9nWrqBpb5IWJO4puYvk2cAaVzl4m///Jbdp
 Nks/e4LamQXG71yK2djd8RnsxDodn3LYHc/gVnUagqRHmb5/bmZxqeOFkZx+ywsOK/ywbSoOt
 o5vrQy2ferL1m/W1eK1QkJJFaS1S0KM1myAnYrHXIQHC3EEmLqH4lddg7EHKWVy0yCtyp9HPo
 /R23+T2Yy031VL27kwyOJ6s9EJio69PhZsUztmIJcl2UG54gDDCEfTPWEV7WgJwmPMhX65wrZ
 6EA/OiR94cL0FsQ4DGyLy2N4JhDEHrm1WCYL++Hy1CrmSULr7nv8P0e6N0tmwVCX8BtOI4wWi
 HxVhYLoxD0u5ajRfyo4sG9hNF4ntQDGUjTJRA9oHHfDOKyftrDNGeRhPkWCFAPjw5MK2cJ8uS
 vAsSOdAwRAKZTcVs7o0ansHBMh3YlOEFj+uuvebmOoJ9PqARVHk9ETllDeaDa9WTxAXTzSRiU
 L4wbqePSeM1wCLzID8drYxH1e8cFntau0h860KBkg3ebaW/tn3030iHTMPTbI0C8Iirf8QjMd
 YMLYKLIM0xce+E18zEq72yoiGDYKPzpXl1Qy5Ciq3awwNZ2my0xwWnyEXJw3RfWYlCikLYQWt
 ImOTpcDu9m2XrC9SDrwmEeDzo2Yf/CFG97b2MAiHR/o4+h1iTcxLt
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 1:04 AM Chunguang Xu <brookxu.cn@gmail.com> wrote:
>
> The kernel has not yet defined ASSERT(). Indeed, BUG() and WARN() are very
> clear and can cover most application scenarios. However, some applications
> require more debugging information and similar behavior to assert(), which
> cannot be directly provided by BUG() and WARN().
>
> Therefore, many modules independently implement ASSERT(), and most of them
> are similar, but slightly different, such as:
>
>  #define ASSERT(expr) \
>          if(!(expr)) { \
>                  printk( "\n" __FILE__ ":%d: Assertion " #expr " failed!\n",__LINE__); \
>                  panic(#expr); \
>          }
>
>  #define ASSERT(x)                                                       \
>  do {                                                                    \
>          if (!(x)) {                                                     \
>                  printk(KERN_EMERG "assertion failed %s: %d: %s\n",      \
>                         __FILE__, __LINE__, #x);                         \
>                  BUG();                                                  \


Generally, I don't think the extra printk() here helps much, as BUG() and
panic() both provide the source location already.

> Some implementations are not optimal for instruction prediction, such as
> missing unlikely():
>
>  #define assert(expr) \
>          if(!(expr)) { \
>          printk( "Assertion failed! %s,%s,%s,line=%d\n",\
>          #expr,__FILE__,__func__,__LINE__); \
>          BUG(); \
>          }
>
> Some implementations have too little log content information, such as:
>
>  #define ASSERT(X)                                               \
>  do {                                                            \
>         if (unlikely(!(X))) {                                   \
>                 printk(KERN_ERR "\n");                          \
>                 printk(KERN_ERR "XXX: Assertion failed\n");     \
>                 BUG();                                          \
>         }                                                       \
>  } while(0)
>
> As we have seen, This makes the code redundant and inconvenient to
> troubleshoot the system. Therefore, perhaps we need to define two
> wrappers for BUG() and WARN_ON(), provide the implementation of ASSERT(),
> simplifyy the code and facilitate problem analysis .
>
> Maybe I missed some information, but I think there is a need to clean
> up the code, maybe in other ways, and more discussion is needed here.
> If this approach is reasonable, I will clean up these codes later and
> issue related patches.

In general, I'd argue that any direct usage of macros like these should
just use BUG(). However it seems that the ones you are replacing
tend to make it conditional on either the 'DEBUG' macro, on a Kconfig
symbol or on some other preprocessor conditional. My feeling is that
if there is some cleanup, maybe we should instead be adding a variant
of BUG_ON() that takes both a preprocessor token (like IS_ENABLED()
does) and a condition.

    Arnd
