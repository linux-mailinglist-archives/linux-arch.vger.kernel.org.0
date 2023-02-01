Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A9E686252
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 10:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBAJE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 04:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjBAJE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 04:04:58 -0500
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [IPv6:2001:4ca0:0:103::81bb:ff8a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAED2ED7B;
        Wed,  1 Feb 2023 01:04:54 -0800 (PST)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4P6GFs3y5ZzyVT;
        Wed,  1 Feb 2023 10:04:49 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        content-type:content-type:mime-version:references:in-reply-to
        :message-id:x-mailer:date:date:subject:subject:from:from
        :received:received; s=tu-postout21; t=1675242289; bh=jvilWdNH19P
        cGhtkD0HTJSTk+P4PDTOwZA4u5wt/Blw=; b=W5mjd0t2iYbWFsqJQ2npccTcXEm
        FIsc0TF578yRlrf6TEHFEBFg3B7c5LolAmhbrDP0AAuNZ+FnsA/hEN0+A4q3PjE0
        uVTeCWgjhS8lhfpEJhMxkTNBpUdHsyjIwYRZGK3bGjuUjO0L1DuVXKZoL3M+Mxqc
        hLtQZfgan9toF6YWyXyOinIkLMDj3raIVvBS6as6ygrkHEysRJLVFhfgMw8iR9kO
        VPdTKglUr8ZrFpmEeNqibI4a6OSJRJxYT9Tf5ICkuyq4iaTnms7j3J3LvC4ELYi5
        wXBfPsfByCxdN3LGaSITM0axfcLtWz6BNjgO4SvbgZ+sCbt8xqHkX4nktDg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.874
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id fvTKPvXBuJxo; Wed,  1 Feb 2023 10:04:49 +0100 (CET)
Received: from [192.168.178.35] (unknown [IPv6:2001:a61:24bf:bb01:2558:6d24:d4e4:8fe4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4P6GFq68dJzyR1;
        Wed,  1 Feb 2023 10:04:47 +0100 (CET)
From:   =?utf-8?q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Shakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: Broken Address Dependency in mm/ksm.c::cmp_and_merge_page()
Date:   Wed, 01 Feb 2023 10:04:42 +0100
X-Mailer: MailMate (1.14r5918)
Message-ID: <C5955FFB-B2DB-48C7-BA82-B81ACF24F94D@tum.de>
In-Reply-To: <Y9GTgdMnGu6OxUZC@boqun-archlinux>
References: <YmKE/XgmRnGKrBbB@Pauls-MacBook-Pro.local>
 <20220426203254.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <YpYAQLi296UFEdTH@ethstick13.dse.in.tum.de>
 <20220531150312.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <0EC00B0E-554A-4BF3-B012-ED1E36B12FD1@tum.de>
 <Y8F3LMlTnT5ZtVTq@rowland.harvard.edu>
 <9E7A62DD-D5DC-4B9C-A592-1A626482563B@tum.de>
 <Y9GTgdMnGu6OxUZC@boqun-archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_35611828-E93B-49F2-83FD-5A909F9E4636_="; micalg=sha-256;
 protocol="application/pkcs7-signature"
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is an S/MIME signed message (RFC 5652 and 8551).

--=_MailMate_35611828-E93B-49F2-83FD-5A909F9E4636_=
Content-Type: text/plain

Hi Boqun,

On 25 Jan 2023, at 21:39, Boqun Feng wrote:

> Hi,
>
> [Cc Rust-for-Linux folks]
>
> No hurries but is your tool avaiable somewhere so that we can have a
> try.

Not ready just yet, but very much on it! Hope to be have something to share very
soon :-)

> Although Rust doesn't support dependencies ordering, but it's good to
> know which dependency is reserved after optimization.

Sure!

Paul

--=_MailMate_35611828-E93B-49F2-83FD-5A909F9E4636_=
Content-Description: S/MIME digital signature
Content-Disposition: attachment; filename=smime.p7s
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDjMw
ggbmMIIEzqADAgECAhAxAnDUNb6bJJr4VtDh4oVJMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0yMDAyMTgwMDAwMDBaFw0zMzA1MDEyMzU5NTlaMEYxCzAJBgNVBAYT
Ak5MMRkwFwYDVQQKExBHRUFOVCBWZXJlbmlnaW5nMRwwGgYDVQQDExNHRUFOVCBQZXJzb25hbCBD
QSA0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAs0riIl4nW+kEWxQENTIgFK600jFA
xs1QwB6hRMqvnkphfy2Q3mKbM2otpELKlgE8/3AQPYBo7p7yeORuPMnAuA+oMGRb2wbeSaLcZbpw
XgfCvnKxmq97/kQkOFX706F9O7/h0yehHhDjUdyMyT0zMs4AMBDRrAFn/b2vR3j0BSYgoQs16oSq
adM3p+d0vvH/YrRMtOhkvGpLuzL8m+LTAQWvQJ92NwCyKiHspoP4mLPJvVpEpDMnpDbRUQdftSpZ
zVKTNORvPrGPRLnJ0EEVCHR82LL6oz915WkrgeCY9ImuulBn4uVsd9ZpubCgM/EXvVBlViKqusCh
SsZEn7juIsGIiDyaIhhLsd3amm8BS3bgK6AxdSMROND6hiHT182Lmf8C+gRHxQG9McvG35uUvRu8
v7bPZiJRaT7ZC2f50P4lTlnbLvWpXv5yv7hheO8bMXltiyLweLB+VNvg+GnfL6TW3Aq1yF1yrZAZ
zR4MbpjTWdEdSLKvz8+0wCwscQ81nbDOwDt9vyZ+0eJXbRkWZiqScnwAg5/B1NUD4TrYlrI4n6zF
p2pyYUOiuzP+as/AZnz63GvjFK69WODR2W/TK4D7VikEMhg18vhuRf4hxnWZOy0vhfDR/g3aJbds
Gac+diahjEwzyB+UKJOCyzvecG8bZ/u/U8PsEMZg07iIPi8CAwEAAaOCAYswggGHMB8GA1UdIwQY
MBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0GA1UdDgQWBBRpAKHHIVj44MUbILAK3adRvxPZ5DAO
BgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYI
KwYBBQUHAwQwOAYDVR0gBDEwLzAtBgRVHSAAMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwudXNlcnRydXN0LmNvbS9VU0VS
VHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYB
BQUHMAKGM2h0dHA6Ly9jcnQudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNy
dDAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOC
AgEACgVOew2PHxM5AP1v7GLGw+3tF6rjAcx43D9Hl110Q+BABABglkrPkES/VyMZsfuds8fcDGvG
E3o5UfjSno4sij0xdKut8zMazv8/4VMKPCA3EUS0tDUoL01ugDdqwlyXuYizeXyH2ICAQfXMtS+r
az7mf741CZvO50OxMUMxqljeRfVPDJQJNHOYi2pxuxgjKDYx4hdZ9G2o+oLlHhu5+anMDkE8g0tf
fjRKn8I1D1BmrDdWR/IdbBOj6870abYvqys1qYlPotv5N5dm+XxQ8vlrvY7+kfQaAYeO3rP1DM8B
GdpEqyFVa+I0rpJPhaZkeWW7cImDQFerHW9bKzBrCC815a3WrEhNpxh72ZJZNs1HYJ+29NTB6uu4
NJjaMxpk+g2puNSm4b9uVjBbPO9V6sFSG+IBqE9ckX/1XjzJtY8Grqoo4SiRb6zcHhp3mxj3oqWi
8SKNohAOKnUc7RIP6ss1hqIFyv0xXZor4N9tnzD0Fo0JDIURjDPEgo5WTdti/MdGTmKFQNqxyZuT
9uSI2Xvhz8p+4pCYkiZqpahZlHqMFxdw9XRZQgrP+cgtOkWEaiNkRBbvtvLdp7MCL2OsQhQEdEbU
vDM9slzZXdI7NjJokVBq3O4pls3VD2z3L/bHVBe0rBERjyM2C/HSIh84rfmAqBgklzIOqXhd+4Rz
adUwggdFMIIFLaADAgECAhEAk3vdiLswPyIHaa7gbRmgujANBgkqhkiG9w0BAQwFADBGMQswCQYD
VQQGEwJOTDEZMBcGA1UEChMQR0VBTlQgVmVyZW5pZ2luZzEcMBoGA1UEAxMTR0VBTlQgUGVyc29u
YWwgQ0EgNDAeFw0yMjExMTAwMDAwMDBaFw0yMzExMTAyMzU5NTlaMIGyMQ4wDAYDVQQREwU4MDMz
MzEpMCcGA1UEChMgVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgTXVlbmNoZW4xGDAWBgNVBAkMD0Fy
Y2lzc3RyYcOfZSAyMTEPMA0GA1UECBMGQmF5ZXJuMQswCQYDVQQGEwJERTEaMBgGA1UEAxMRUGF1
bCBIZWlkZWtydWVnZXIxITAfBgkqhkiG9w0BCQEWEmhlaWRla3JwQGluLnR1bS5kZTCCAaIwDQYJ
KoZIhvcNAQEBBQADggGPADCCAYoCggGBAMa35V6bAKqaFCEcfVMsBMW5hdegZmzIy1qHgdX4SHo0
2DPMinoi8M//hF5+SQNODMPAwkMGM2JLV6jq51ZvNV5AMmyp1cPuNUyX6ZcZsz9l67Q93D+TkQ8P
cO9zc1RBdQdRhpQDLe+m+psN/ABjGnp7tmcG/gyQmQOlcoAdtO/FJeHwdewNgi/Lbo3CnoseUYFF
j1KiVnR4BxzTELFg+VNBbQ71LtbqhG2mO9p6o/1iD5ImKDB/cdNDVEikVpxVIsHYWnzr6a8jc+iK
H52aVhMXlq3us1ENrRJ4n45an9h6TMgDZHoASo3nXTnj2GSgxOps5utr+Xbxq9OTxr1YocI7sPeg
mK2/Jl99WXLjGWmjpjq+3wGP6YWvk9DjyhWZinBuqaXhOKEzb62rmWw+K5oiI3DNXB95RhywYVO8
j7JwU8MrSOLFVgHRD4JfUZr9B7rrEnOW9IbOBFPN7QfNz3j28EnTAS5jcIhxtZV0vySjnhC3XUvH
MWghCJx8h0h7JQIDAQABo4ICPzCCAjswHwYDVR0jBBgwFoAUaQChxyFY+ODFGyCwCt2nUb8T2eQw
HQYDVR0OBBYEFEGvRvAmg05NopUV9pH7SMbFiVwTMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjA/BgNVHSAEODA2MDQGCysGAQQBsjEB
AgJPMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEIGA1UdHwQ7MDkwN6A1
oDOGMWh0dHA6Ly9HRUFOVC5jcmwuc2VjdGlnby5jb20vR0VBTlRQZXJzb25hbENBNC5jcmwweAYI
KwYBBQUHAQEEbDBqMD0GCCsGAQUFBzAChjFodHRwOi8vR0VBTlQuY3J0LnNlY3RpZ28uY29tL0dF
QU5UUGVyc29uYWxDQTQuY3J0MCkGCCsGAQUFBzABhh1odHRwOi8vR0VBTlQub2NzcC5zZWN0aWdv
LmNvbTCBvAYDVR0RBIG0MIGxgRtQYXVsLkhlaWRla3J1ZWdlckBpbi50dW0uZGWBE2hlaWRla3Jw
QGNpdC50dW0uZGWBHFBhdWwuSGVpZGVrcnVlZ2VyQGNpdC50dW0uZGWBE2hlaWRla3JwQGNzLnR1
bS5lZHWBHFBhdWwuSGVpZGVrcnVlZ2VyQGNzLnR1bS5lZHWBGHBhdWwuaGVpZGVrcnVlZ2VyQHR1
bS5kZYESaGVpZGVrcnBAaW4udHVtLmRlMA0GCSqGSIb3DQEBDAUAA4ICAQB0h9s7S7zb3sZpe67K
Q8Ko0pkM9WbMO6X/6fscdWHZNiQQfn6X+9A7IPT+bGx9mC3vRO1TOR7FfmgAKs8xpqW2PAC4taIz
EdXhrKCJuIzqzdhqQBMhfoP9giurXsQxaYAWeuEklmw1cIEoG6guVOo7Re+Vqx74rHOf6gDgukUz
J1uhto0FVhPLZqzjdGBfPNhXc+9W7ow4Fu8w37lKdDi9DRCkFO+Wq+jzApzIEIInT1lhDt7Y81wJ
UTqcYn2tOLSpwB38Hd798RDkeY5f3EO/+pLNpEhnwXSpAif/cpZCKXf2LrZRSdH3wbxefj/HLu/w
tuZ+lQsRXKEMJbBeXw8DEKP8771chCGyLl8AHhJRHrcokhX/PPJu/y0t5ArvMNeumFjGtxtczyHU
ieT3EcE8oG5aMyD0Ly+Lwc0L90DqcXUvU1xbHL9GxMOTPZGz0Qr0qZDBv60oTUbIXIMIyyoY0rsO
NtncPyZKMkLaRUBwrWXF+BuxM5hfDytIbSKtO/Q6woFihf6xyKHVqAhoyV6y19WAYIEb78ce+zOg
xyOOYPiVNiKlwP8gJq72mrfUvUggpyPVwjEkhye/+d98NrylwyWokJI6PWM1YsOmdG1s+4fiU7KU
9+PEIW/YMpUiGYViXzt0RZfuKNixCk1Jh+JtGU44/cuz+Oki3ooAIqaRKTGCAo4wggKKAgEBMFsw
RjELMAkGA1UEBhMCTkwxGTAXBgNVBAoTEEdFQU5UIFZlcmVuaWdpbmcxHDAaBgNVBAMTE0dFQU5U
IFBlcnNvbmFsIENBIDQCEQCTe92IuzA/IgdpruBtGaC6MA0GCWCGSAFlAwQCAQUAoIGFMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwLwYJKoZIhvcNAQkEMSIEIDHM3pc9jImPH19F1z1+IUTIzcM2
G5aes9CDYtDThT97MDgGCSqGSIb3DQEJDzErMCkwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDANBgkqhkiG9w0BAQsFAASCAYAMMClDI35QDAcUGrNzHKeLCAUgT8AKnkwa
9VTLbPhUL0TCc8rDEG5HCPybO3+JP2O5JSG8GTBLsM1rRanfz1qfLj6CAPMgOypYPern9l9UoadE
GHeIJgnWFcPhgj41VSTNC2edxB0+Nd5iYu/tf7qyGhu9soMpV4SjqR3CVOOunel5/uYLRvBWmjy2
t/Dk+BEcez1nxsAUu2Z7kR8QLicQUUaUfxUqbnMYjZICJyhg4Lw1wWmRkbP9fKPEh5PY5mVh+UlZ
ZBUkR85p/kyJRB6Dz5A2z4OZEtyVRZCVNm8tPqa3CNsrLrNkrSW01U2qTqZRGFUQhQzlyTKD+18q
NRxoNkpBVF2yZKfsV0qS4mllViBZB5+pEI5z7SpKjUaoOndGl0HMLOyPbEA8bHit1ajFbBOc7NXm
rLXYbnXcruRk8RwfMLYIJdo3cjOPgSqQS4Whb584F9IESmOzcLlq+XmfwQ9c2iysQr0/AYwp5REN
+5JbHdif8ZmdxBzIip6PNBIAAAAAAAA=
--=_MailMate_35611828-E93B-49F2-83FD-5A909F9E4636_=--
