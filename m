Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93A424209B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Aug 2020 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKTwO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Aug 2020 15:52:14 -0400
Received: from sonic304-10.consmr.mail.bf2.yahoo.com ([74.6.128.33]:40018 "EHLO
        sonic304-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgHKTwO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 15:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1597175533; bh=A26Tg+Pk4QH3U1HJc53qJOy0JwCT0JkMhdiBXpuSJFc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=o4hbqgsW0nGFrDfNEthMnJ88wOwUr86EKnqRtEvKzCnebBah4uepQX3HhP0MBY9LxvmUkaaYHY1+q8Da60+x7MUk9dWL8cZUVySzmDdIJexfAKalPEbsmnyZYRxyL35bWASEMe70s4NBYcekaIi7b950SdXRc2YHRyGuEbTZ9GxtwuDbaN99/oWoENp8p/P8eoRsN/Jx6JUO8vXNH/hNZMBp7rhwN4kj8efoMdD7n6Pmivw6E+B7i6C6CiQ6OequuCIPUJSICrC1XPrinIuHXkXrrL0rzLK87KiXGOus0oAhx/KCYIxHOjgZEfnB993FymwmshBHz62Gcv4jSjya0w==
X-YMail-OSG: rs67cKEVM1lHdJBpg5KYbjZ_uzQ2RIUkH1ZE.NIn_6f9OtOL0VslTcYYP5pPFQw
 SJWoz2WnQTkogO8XbrLzR0BO_Wy56mYhsciRx0a3UON8GAkjSWu9fiNbCJUCZ.C5N7RouAWRInVt
 hZuooXipiTda8pRY7eiJHJ_v_reIWiQ4UFKkj.9pDSrv39ITWpAKJveW1kVZYDi7FviIx_VzMk0F
 CKNrFtGzQX81HsgrUiRwMV66zzfxhy_705KcdBb8xhK_PLvB1fN5n_a6D7SliAsb8fKxfDs8I_im
 RvCeU1jkp2wDuzGhuYjsHuCyurgJObFq4H2tJNs946jcLZ4LNkGT4fKnE5nLNxC6zObQAWb9rGdh
 l0B6J_H70lsXWLDxd34OIcPRInM._TO1AEZqANZy4CwG9zAQddL4Bo2pNyENduZS6Yn_b28IbXqr
 ah2sAn6129iPPJUbUfoMESJDUMa9TQXCN64EFuUdKhBlTCZfNWTZy3cYQ11Dqnqzo2eBgM7TeeA6
 Gf2IR7x8.7J5LKV_pCNHlQhzMafqzEKXz_vDbFKd8AxP2646JIE9yP.LpX4lwqb.6VOEAESi9_xn
 fF53VfevLzpDRjNzg4Wjz3DCPzAUaltBOrX2gFqFNCqEbsBHGKiwLCPP1_3o6AHmi_0l9wW_zeDN
 adKjIGOPcV6HqAf31TexcahkCW139C_necDyboVwg7r2Oj.dmxqaQAf4ErsadZA3OmPirnz3l.wF
 9xX96BIaTNpFS20l3WVdD_Cbw.h1MpjnlaWePNNuNKoFfb3OB3QoceMp_cuIKcUrWd94izMAxJHb
 miWPTUAAwtuYRLLm0hkiukCKlPws5hLm5jwWqGWBKOCLpkkJ.kcTtdeKqjqDsx1xG3Abt3vjQZP_
 vu3lMM9v8qnMVR7J0Mu7cHG3sGwiyFhRkb44JG_2cWU90hYFE7iF5NSeX9n0RtX3exVJ6sw2cyKG
 mizpBYBsOMxk0NxZZw5adi2SoLInLD8wCIfqkpWUjfaovZtZIlMFAsARIBxAHmlRfXHhJ1o7jZDn
 6rBh99wZskFXjh.NHzI6Ohw4fxxvVlKJZqSNz7_Jl.CtIUdYUaj9pY4W1rhr7kgF.P2aIvVixGw5
 apFXQdZr64alcqkXvVowdexaxrLZmERY.o0LadtB8wBPyoY.k5W0K1Br6BI2U.cECG994SWDywJU
 lFXLrHAm5RHQTwASPgMwxNB2tePtmj5hJoEC7spXIFqNfjtWETf2EyaUmm5N3npqR3uNQRivoiCI
 v6Q.oSN.ijnLIuT1zT2i1te0WV.31LkbW5S8Y5ghHtrojyFclnFulBvOZTqFoHff2LgN5P5cj9nz
 vhNGMqa3g1qfTESJaoW.K56oGqnKgPCF_QSmPTA.wLsow00kE9A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 11 Aug 2020 19:52:13 +0000
Date:   Tue, 11 Aug 2020 19:52:09 +0000 (UTC)
From:   Aisha Gadafi <aishagadafi100@aol.com>
Reply-To: aishagadafi609@gmail.com
Message-ID: <2118364924.335373.1597175529292@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2118364924.335373.1597175529292.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greetings of the day from Mrs Aisha Gaddafi

Dear Friend,
Greetings and Nice Day.
Assalamu Alaikum
May i  use this medium to open a mutual communication with you seeking your acceptance towards investing in your country under your management as my partner, My name is Aisha  Gaddafi and presently living in Oman, i am a Widow and single Mother with three Children, the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi) and presently i am under political asylum protection by the Omani Government.

I have funds worth "Twenty Seven Million Five Hundred Thousand United State Dollars" -$27.500.000.00 US Dollars which i want to entrust on you for investment project in your country.If you are willing to handle this project on my behalf, kindly reply urgent to enable me provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address below:
 
aishagadafi609@gmail.com

Best Regards
Mrs Aisha Gaddafi
