Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489332EF64C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Jan 2021 18:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbhAHRMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Jan 2021 12:12:39 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46387
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbhAHRMi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2021 12:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610125911; bh=j9cxGBcHB4d+zSYQ4XhAThNxb9KCF05XAEpovLi1aXU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=nWivqiaFjCp93w6tp+1Hqz8qYHI/5Wl6V2asHXJLrjdQ3uCNlTDR/cV9B2ABXQJr85FNJ5vY50xfmamArlP3gZzgSO6ehNKgWvPZFSiyPvprh3SvonG63BSTnljOtvgC8Ehgp0dgcm2sHyndHjT1oL8t3omhO8+orVIJhzoKTFJJmjel0VFjtwgHJORmN5eYkKF3ugAej9YpW3GbeymnzEWqHfItTQ7B6rIOKZ9VjldW0ZtdSqBFhxWfUJdW8nQ7TwQ3dVvUfkihflyNG4V4jbNdKr1GmBOPrR3UOQpeWn/+Hx1yBNv2jfIm3M4V6JJatZkxAyhlajalbthlRL7Gzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1610125911; bh=3l2Y41zen/zRnXH4XtlCJD9x4Qj3OYV8OZrwItWZFUq=; h=Subject:To:From:Date:From:Subject; b=ilYl8A2XRZOHcMOj22zlPWE/W8WdOfDS/hoHHsYyRfgU1IhFtJcDVx1QNhwGp4VtCE2sJUibxK9jwpIDZB0cP1CE0mbZNbXvqTstblHgimHuKMllicx1Ofa8xcBfcUEE7zCaXC68i8HarM7cnZaT5qXnwXBO96l6ksqnqm5tvALPaDIvLA8E073qZG/5QHj8HAyklrmD5rBu0TYSK1fs4WhCdnvG3y65DF9k386YcbIGxGGm75zVGkSTwwPrHo1t2D5kcDbhDAcOQs5XQCfnrNstrvQa5Pi4Jt0WtVffRxhJkmxxLS5xHVDlqIXttW580Mq46pFufahJ4kVuOa4W1g==
X-YMail-OSG: _Ko6miMVM1leikAxz96CkMxWfNE_zhhoPGAQp3NWfAS7SLJmpnz2ntPOhz5nRUy
 ehEENzm0XFkNf.OPuHPqStZUZDqny6TiwCnCdKvnfMGc73V10rsHXaNU0nsYaTH.7m9MxPr7PJlf
 m11W8bpR9sj1NrrSGmKNF0cBLITkHqrTPyVyNCMnFCZX_jZQpfGcqmSzizgJt6Nu_QLHgXEa59Fc
 dpniyDILhKUGEFI.hN0pdYVP2NBqByaukCx2AQvKRIPafXEh7_hd44g8hlLSf3Fxn3IQ1BbSwKoN
 upQoekkmVjThArC_vU_g5_CJ47y73R8PWqBHeXAYLDSxIVhCcktuP.mSAPIn1Qshunz9KDl5jfa3
 EWoVpXCJT2uLv9_dIBvRQphrD3VxhkVKUYLehNa719a0MS40fIuIk83_Yi_y91VUxf7G36qDsfkN
 CMLpVsn0BE49U6b0cykBUHBlevywrMjRy.uOjOGdSdscFbnLWv0tL41Duc43zOKnO5UVxvIi3SxU
 qMPxYZIFcncY9nLTFYyK6U7L_TgPVk2Bi7aN0J.BVnzlJgDUZO8wokXPTLkH6FAktzN1SGUML7X2
 nBtAelOwdB7CqFjGPOmOwlZYilZdTYkRM2w6UhprVSgEMGPpl86IxXPVkGWzMkqxSNxkQM1fDKYA
 j85aAQfT8ETWdwurO8FLOysf8jZmIak5syXcaROybD1rpv7_WR2O1YFh7ZUV3F0XOv8x5ZOZhFca
 zXH4iPjXJN6TtLLbvk_ts0R47FKBO4M1gLmGkXeKWOV._Jy9xTgU7LFdmV0J2XxnNxlAopzsOPgh
 ycMMl4YqPRfAQX9icWZwt6gCJQSmmn_.jggV2TP122t4G4EqijXXPDHhcFeOhWhiRVaAEpO2b1Wb
 pdnSgY0bOzbAJp958pTETiOWylhUcvWsY_YhKrJ0Fjfl6FwNzlCB5_2FgJS1ugtV1EMTbXd20qUR
 PDoJ3kilwFkreKJO0nyvFtN8sDUzWRagmXf7mweLgStG4OwukdulHcmjZU.YKsMXcztfOf2e8pU2
 9Ibv7rn71bSrwFF4iyyHtaBuhXTMSx_R7mbVFzvyle1MRlGfN4wKPDHwyy8CkAJqSJuAxRuZlHKx
 sM2oaSqbVlIq3_m0AXP4r9a8CMGtByOp0gEMmxXJHlGgXOltRdgDxU1KziJ87_iZDNJTtJczgyXG
 smiMbQy1O_WgubNRui2kwL.skB9bEbkuzlt0efxoS3MxlMiKmIAC5egb2LGfJi2gHnkbgqimGXRj
 LcaLgJ836UOzEoFQ5ZcbmN0GnuNOCh6kB96ERXrtjVJvekavY0b8JZRH5ROR4mfXNHG_yJsDwMKX
 XtEttzw_nV1QxANcA9L8xcBCxm_hlJL1FlhPYJqT9oucCGIA5UscrqqLh3A_fI0R2YeMErt_BzH9
 LxolwRdLKi5Dk4f0TQLC8UTxJ4SKevj1c10XWkGZg4j_miEIBBIRA2tJJGha82JF06D8V3EfF02b
 rRGyOJAg5j.EMeo0ZEmKWae86egAkst4M8A2W.911xPEwc4xej6XuUJUfo8mD6Bt6Tygv_Lr8B34
 ox.XoAZTIPaIek6UJBB85nvV73xQ8yw6HKRvQXQiXObil9lMJYsSHlfeh.mef9SGbJlBB57o6p9Z
 2JimVtk4Zd6XkRBgkdOfVeY8sznhIU53O3R189xowf0XiKkaPfGqPc4d14oTOxLLzBzEoaj45z0j
 X2xAptSoJ0Dbm2cNqXzO79DZRJbpTML5N4spKhYLvoIFGZwDjlfCrydzQlErKQiBuRLk2G2tfF2h
 H7gZLyIb2SlUTxWQ6TrfsKgqf5obKBcBD1u3PywJ607JiFM67STyHIO9ojqOy2WL7QEesgWG8IS7
 UZFUaC9VYSjGhp7z1T606GZUlnIZ3junXJs3yxkESTrmQoFBVhZdAR78iRWx7NXcNsiLRT9Y1LqL
 AsLzxAvFqAkQvQ35hLFcXO.63uhqw3wAfpmcb0w4e4gyYgbSrTxR3Uq6DyMascM0V_i94KFy8m6T
 H_cu8MnQJzh_ipPcoY8SgzY8zRyTS8doXv6_GMIinoaUtHlWxJYEInEPVGt9h.viK2T.Q5fYrqqo
 81HfTm4EYb4LodY9Xbllnex_8hCDcK3dQw2XU2rr4RREhIeRoNlMu_m8BDpX6.lsUspS3JxUKPUl
 npldswtZktGA4F1kAOt.hOjIYcgv.5EoRqKTyWtdPRAn_7yxAT4WjR_Fc8ucO7UV0IZIMBimYyOK
 xYDZxF2yMx1LtcEVKatSAOi4oVsQWJN7yEO92P6WhI2UWIRiH0v1hyHmhqAlnISJPJPI06nyOiWt
 vsX6QzlX3W8i.IR6ODeX4PpKc_YPWVpKBS9ENbL5r6XHiDBD5qNNKG2AuCgto4Bu9NNIZY7l.ZH_
 L1t3G_deNSNFgLKr.9iDMnCDSYskpJYR1StGwiS6dH9_UPayw4c.vkIyJLO9jKMB3g74U07Ez3b6
 F3g0FZozFyArWlH7LRNF2BDouQVLEuIf80fxAQxFRY5Vpm_i4CKidu2Mh4Om_BcAhiINk4OHmFRX
 A3LZCKvfbN6sZdd.7Mk5RObq7MZnKO6Xbjn3v1Di6M8TOkI2NdeCrYwLRv_t2aT12p4goIrO5pbz
 pNK8dkVK5T09q.puYzqJ91hJRWblVhNedwv5nBmYNSAtPoABt3qoogpYG.Y.tVXueq0gQ5k6hUiN
 ylMGwx0ed7.5fW7nCZEpANU_NTkcgai3kWBCrAwdCNCV75ywTT.8o7QEtmE5ymm9ojm4b4KuOWg3
 taF80hxTvbzRzcHTxqeCSo38mec.qk.L9yN_UtZF7mpO_QW8hDpTi8TuVPZAzUen79EHbVZC2fea
 6m6VJ9udf4uXmOn2Lm3I7UvQ26b5MUvTBEsq9sumOeMqGHXhWRyi.SVkkA_uYGxVR4HNC7dN2DNt
 zJzh7U7puKzDZgeTLwZ4Pxn73NkEBRWDcHyiErTkkgz7yM2j2fb.E6F4c7EYkuL5AhiUg88azVLM
 TaOl1iFvIst0X9UMLdmAg4c0KGEku_29_NKltSagBvZIfbEHcZeslA_0HZFeJ312hE6cIMGu8eOt
 03gRce8sTSWf7GRbf70kKpkzDYeDm3S5LaMLFR3d3Wry2MfxQ1j2tp2L9hHA5OFa.fjf2OyX0Y2N
 oB2o9Uox_IK5yH7cuBLMAijuXjRitQ.y6NVlFKYxf7LNnD3BCLXToV8zplDS1.AQFbmyxgi4Ucku
 j5p08I1J.kvCOcAUmWhaOPwPG_c8A7K4nJ1XCxqS.e6WAP2fbxKXY7eLJ3u66aj6X8vna3Dy1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 8 Jan 2021 17:11:51 +0000
Received: by smtp413.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7af7cbaa52cc6f301368e3b4ad7490a5;
          Fri, 08 Jan 2021 17:11:45 +0000 (UTC)
Subject: Re: [RFC PATCH v2] selinux: security: Move selinux_state to a
 separate page
To:     Preeti Nagar <pnagar@codeaurora.org>, arnd@arndb.de,
        jmorris@namei.org, serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     psodagud@codeaurora.org, nmardana@codeaurora.org,
        dsule@codeaurora.org, Joe Perches <joe@perches.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0f467390-e018-6051-0014-ab475ed76863@schaufler-ca.com>
Date:   Fri, 8 Jan 2021 09:11:44 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610099389-28329-1-git-send-email-pnagar@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/8/2021 1:49 AM, Preeti Nagar wrote:
> The changes introduce a new security feature, RunTime Integrity Check
> (RTIC), designed to protect Linux Kernel at runtime. The motivation
> behind these changes is:
> 1. The system protection offered by SE for Android relies on the
> assumption of kernel integrity. If the kernel itself is compromised (by=

> a perhaps as yet unknown future vulnerability), SE for Android security=

> mechanisms could potentially be disabled and rendered ineffective.
> 2. Qualcomm Snapdragon devices use Secure Boot, which adds cryptographi=
c
> checks to each stage of the boot-up process, to assert the authenticity=

> of all secure software images that the device executes.  However, due t=
o
> various vulnerabilities in SW modules, the integrity of the system can =
be
> compromised at any time after device boot-up, leading to un-authorized
> SW executing.

It would be helpful if you characterized the "various vulnerabilities"
rather than simply asserting their existence. This would allow the review=
er
to determine if the proposed patch addresses the issue.

>
> The feature's idea is to move some sensitive kernel structures to a
> separate page and monitor further any unauthorized changes to these,
> from higher Exception Levels using stage 2 MMU. Moving these to a
> different page will help avoid getting page faults from un-related data=
=2E

I've always been a little slow when it comes to understanding the
details of advanced memory management facilities. That's part of
why I work in access control. Could you expand this a bit, so that
someone who doesn't already know how your stage 2 MMU works might
be able to evaluate what you're doing here.

> Using this mechanism, some sensitive variables of the kernel which are
> initialized after init or are updated rarely can also be protected from=

> simple overwrites and attacks trying to modify these.

How would this interact with or complement __read_mostly?

>
> Currently, the change moves selinux_state structure to a separate page.=
 In
> future we plan to move more security-related kernel assets to this page=
 to
> enhance protection.

What's special about selinux_state? What about the SELinux policy?
How would I, as maintainer of the Smack security module, know if
some Smack data should be treated the same way?=20

>
> We want to seek your suggestions and comments on the idea and the chang=
es
> in the patch.
>
> Signed-off-by: Preeti Nagar <pnagar@codeaurora.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++++
>  include/linux/init.h              |  4 ++++
>  security/Kconfig                  | 10 ++++++++++
>  security/selinux/hooks.c          |  4 ++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> index b2b3d81..158dbc2 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -770,6 +770,15 @@
>  		*(.scommon)						\
>  	}
> =20
> +#ifdef CONFIG_SECURITY_RTIC
> +#define RTIC_BSS							\
> +	. =3D ALIGN(PAGE_SIZE);						\
> +	KEEP(*(.bss.rtic))						\
> +	. =3D ALIGN(PAGE_SIZE);
> +#else
> +#define RTIC_BSS
> +#endif
> +
>  /*
>   * Allow archectures to redefine BSS_FIRST_SECTIONS to add extra
>   * sections to the front of bss.
> @@ -782,6 +791,7 @@
>  	. =3D ALIGN(bss_align);						\
>  	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
>  		BSS_FIRST_SECTIONS					\
> +		RTIC_BSS						\
>  		. =3D ALIGN(PAGE_SIZE);					\
>  		*(.bss..page_aligned)					\
>  		. =3D ALIGN(PAGE_SIZE);					\
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 7b53cb3..617adcf 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -300,6 +300,10 @@ void __init parse_early_options(char *cmdline);
>  /* Data marked not to be saved by software suspend */
>  #define __nosavedata __section(".data..nosave")
> =20
> +#ifdef CONFIG_SECURITY_RTIC
> +#define __rticdata  __section(".bss.rtic")
> +#endif
> +
>  #ifdef MODULE
>  #define __exit_p(x) x
>  #else
> diff --git a/security/Kconfig b/security/Kconfig
> index 7561f6f..66b61b9 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -291,5 +291,15 @@ config LSM
> =20
>  source "security/Kconfig.hardening"
> =20
> +config SECURITY_RTIC
> +        bool "RunTime Integrity Check feature"

Shouldn't this depend on the architecture(s) supporting the
feature?

> +        help
> +	  RTIC(RunTime Integrity Check) feature is to protect Linux kernel
> +	  at runtime. This relocates some of the security sensitive kernel
> +	  structures to a separate page aligned special section.
> +
> +	  This is to enable monitoring and protection of these kernel assets
> +	  from a higher exception level(EL) against any unauthorized changes.=


"if you are unsure ..."

> +
>  endmenu
> =20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826f..7add17c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -104,7 +104,11 @@
>  #include "audit.h"
>  #include "avc_ss.h"
> =20
> +#ifdef CONFIG_SECURITY_RTIC
> +struct selinux_state selinux_state __rticdata;
> +#else
>  struct selinux_state selinux_state;
> +#endif

Shouldn't the __rticdata tag be applied always, and its
definition take care of the cases where it doesn't do anything?

> =20
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount =3D ATOMIC_INIT(0);

